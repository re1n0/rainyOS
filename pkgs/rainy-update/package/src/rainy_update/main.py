"""
Run `passthru.updateScript` for flake packages, via nix-update

By default this script *edits* files.
Pass exactly one of:
  * --commit  to commit each update directly to the current branch,
    following the nixpkgs convention `<pname>: <oldVersion> -> <newVersion>`
  * --pr      to open one PR per updated package instead, requesting review
    from whoever is listed in that package's meta.maintainers (GitHub or a
    self-hosted Forgejo instance -- see --forge/--forge-url)
"""

from __future__ import annotations

import argparse
import datetime as dt
import json
import os
import re
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path

from nix_update.eval import eval_attr
from nix_update.options import Options
from nix_update.update import update as run_nix_update

from rainy_update import forge as forge_mod


NIX_UPDATE_EXTRA_FLAGS = ["--extra-experimental-features", "flakes nix-command"]


@dataclass
class PrConfig:
    forge: forge_mod.Forge
    owner: str
    repo: str
    base_branch: str
    maintainer_attr: str
    assign_maintainers: bool


def run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, text=True, **kw)


def git(root: Path, *args: str, **kw) -> subprocess.CompletedProcess:
    return run(["git", "-C", str(root), *args], **kw)


def nix_current_system() -> str:
    r = run(
        ["nix", "eval", "--impure", "--raw", "--expr", "builtins.currentSystem"],
        capture_output=True,
        check=True,
    )
    return r.stdout.strip()


# Package discovery


def discover_local_packages(local_dir: Path) -> list[str]:
    names: set[str] = set()

    for pkg_nix in local_dir.glob("*/package.nix"):
        names.add(pkg_nix.parent.name)

    development_dir = local_dir / "development"
    if development_dir.is_dir():
        for default_nix in development_dir.glob("*/*/default.nix"):
            names.add(default_nix.parent.name)

    return sorted(names)


def discover_flake_packages(root: Path) -> list[str]:
    expr = (
        "builtins.attrNames (builtins.getFlake "
        + json.dumps(str(root))
        + ").packages.${builtins.currentSystem}"
    )
    r = run(
        ["nix", "eval", "--impure", "--json", "--expr", expr],
        cwd=root,
        capture_output=True,
    )
    if r.returncode != 0:
        raise RuntimeError(
            "failed to enumerate packages.<system> (pass --local-dir to scan a "
            f"directory instead):\n{r.stderr.strip()}"
        )
    return sorted(json.loads(r.stdout))


def discover_packages(root: Path, local_dir: str | None) -> list[str]:
    if local_dir:
        return discover_local_packages(root / local_dir)
    return discover_flake_packages(root)


def package_dir(root: Path, filename: str) -> str:
    """Directory (relative to root when possible) containing the package
    definition nix-update just edited -- computed from what it actually
    reports, rather than guessed from directory-scan conventions, so it
    works the same whether the package came from --local-dir or from
    evaluating legacyPackages."""
    path = Path(filename).parent
    try:
        return str(path.relative_to(root))
    except ValueError:
        return str(path)


# git plumbing


def working_tree_dirty(root: Path, path: str) -> bool:
    r = git(root, "status", "--porcelain", "--", path, capture_output=True, check=True)
    return bool(r.stdout.strip())


def commit_package(root: Path, path: str, message: str) -> bool:
    git(root, "add", "-A", "--", path, check=True)
    if git(root, "diff", "--cached", "--quiet", "--", path).returncode == 0:
        return False
    git(root, "commit", "--quiet", "-m", message, "--", path, check=True)
    return True


def branch_exists(root: Path, branch: str) -> bool:
    local = (
        git(
            root, "rev-parse", "--verify", "--quiet", branch, capture_output=True
        ).returncode
        == 0
    )
    remote = (
        git(
            root,
            "ls-remote",
            "--exit-code",
            "--heads",
            "origin",
            branch,
            capture_output=True,
        ).returncode
        == 0
    )
    return local or remote


def remote_owner_repo(root: Path, remote: str = "origin") -> tuple[str, str]:
    url = git(
        root, "remote", "get-url", remote, capture_output=True, check=True
    ).stdout.strip()
    m = re.search(r"[:/]([^/:]+)/([^/]+?)(\.git)?$", url)
    if not m:
        raise RuntimeError(f"could not parse owner/repo from remote url: {url}")
    return m.group(1), m.group(2)


def detect_base_branch(root: Path) -> str:
    r = git(root, "symbolic-ref", "refs/remotes/origin/HEAD", capture_output=True)
    if r.returncode == 0:
        return r.stdout.strip().rsplit("/", 1)[-1]
    return "main"


def guess_forge_kind(root: Path) -> str:
    url = git(
        root, "remote", "get-url", "origin", capture_output=True, check=True
    ).stdout.strip()
    return "github" if "github.com" in url else "forgejo"


def get_token(env_names: list[str]) -> str:
    for name in env_names:
        val = os.environ.get(name)
        if val:
            return val
    raise RuntimeError(f"no token found in env vars: {', '.join(env_names)}")


def reviewer_usernames(maintainers: list[dict] | None, attr: str) -> list[str]:
    return sorted({m[attr] for m in (maintainers or []) if m.get(attr)})


def open_pr(
    root: Path,
    pkg_path: str,
    branch: str,
    message: str,
    body: str,
    maintainers: list[dict] | None,
    cfg: PrConfig,
) -> dict:
    """Commit pkg_path (already modified in the working tree) onto a fresh
    branch, push it, and open a PR requesting review from any maintainers
    that have cfg.maintainer_attr set."""
    if branch_exists(root, branch):
        git(root, "checkout", "--", pkg_path)
        return {"status": "skipped", "reason": f"branch {branch} already exists"}

    git(root, "switch", "-c", branch, check=True)
    committed = commit_package(root, pkg_path, message)
    if not committed:
        git(root, "switch", cfg.base_branch, check=True)
        git(root, "branch", "-D", branch, check=True)
        return {"status": "unchanged"}

    git(root, "push", "--force-with-lease", "-u", "origin", branch, check=True)
    pr = cfg.forge.create_pr(
        cfg.owner,
        cfg.repo,
        title=message,
        body=body,
        head=branch,
        base=cfg.base_branch,
    )

    reviewers: list[str] = []
    if cfg.assign_maintainers:
        reviewers = reviewer_usernames(maintainers, cfg.maintainer_attr)
        if reviewers:
            cfg.forge.request_reviewers(cfg.owner, cfg.repo, pr, reviewers)

    git(root, "switch", cfg.base_branch, check=True)
    return {"status": "pr-opened", "pr_url": pr.url, "reviewers": reviewers}


# nix-update


def make_options(root: Path, attribute: str) -> Options:
    return Options(
        attribute=attribute,
        flake=True,
        import_path=str(root),
        use_update_script=True,
        extra_flags=NIX_UPDATE_EXTRA_FLAGS,
        quiet=True,
    )


def handle_self_commit(
    root: Path,
    name: str,
    pname: str,
    old_version: str | None,
    new_version: str | None,
    maintainers: list[dict] | None,
    before_head: str,
    pr_config: PrConfig | None,
) -> dict:
    """The update script committed on its own (supportedFeatures = ["commit"],
    or some other self-committing script). This happens regardless of
    --commit/default mode, since the script -- not us -- made the commit.
    In --pr mode, peel that commit onto its own branch so it doesn't leak
    onto the base branch."""
    if pr_config is None:
        return {
            "name": name,
            "status": "updated",
            "old": old_version,
            "new": new_version,
            "self_committed": True,
        }

    branch = f"update-{name}-{new_version}"
    if branch_exists(root, branch):
        git(root, "reset", "--hard", before_head, check=True)
        return {
            "name": name,
            "status": "skipped",
            "reason": f"branch {branch} already exists",
        }
    git(root, "branch", branch, check=True)
    git(root, "reset", "--hard", before_head, check=True)
    git(root, "push", "--force-with-lease", "-u", "origin", branch, check=True)
    message = f"{pname}: {old_version} -> {new_version}"
    pr = pr_config.forge.create_pr(
        pr_config.owner,
        pr_config.repo,
        title=message,
        body="Automated update.",
        head=branch,
        base=pr_config.base_branch,
    )
    reviewers = []
    if pr_config.assign_maintainers:
        reviewers = reviewer_usernames(maintainers, pr_config.maintainer_attr)
        if reviewers:
            pr_config.forge.request_reviewers(
                pr_config.owner, pr_config.repo, pr, reviewers
            )
    return {
        "name": name,
        "status": "updated",
        "old": old_version,
        "new": new_version,
        "self_committed": True,
        "pr_url": pr.url,
        "reviewers": reviewers,
    }


def update_one(
    root: Path,
    name: str,
    attribute_prefix: str,
    dry_run: bool,
    do_commit: bool,
    pr_config: PrConfig | None,
) -> dict:
    opts = make_options(root, attribute_prefix + name)

    try:
        probe = eval_attr(opts)
    except Exception as e:
        return {"name": name, "status": "failed", "reason": f"eval failed: {e}"}

    if not probe.has_update_script:
        return {"name": name, "status": "skipped", "reason": "no passthru.updateScript"}

    pkg_path = package_dir(root, probe.filename)

    if working_tree_dirty(root, pkg_path):
        return {
            "name": name,
            "status": "skipped",
            "reason": f"{pkg_path} already has uncommitted changes",
        }

    old_version = probe.old_version
    pname = probe.pname or name
    maintainers = probe.maintainers or []

    before_head = git(
        root, "rev-parse", "HEAD", capture_output=True, check=True
    ).stdout.strip()

    try:
        package = run_nix_update(opts)
    except Exception as e:
        return {"name": name, "status": "failed", "reason": str(e)}

    new_version = getattr(package.new_version, "number", None) or old_version

    after_head = git(
        root, "rev-parse", "HEAD", capture_output=True, check=True
    ).stdout.strip()
    if after_head != before_head:
        return handle_self_commit(
            root,
            name,
            pname,
            old_version,
            new_version,
            maintainers,
            before_head,
            pr_config,
        )

    if not working_tree_dirty(root, pkg_path):
        return {
            "name": name,
            "status": "unchanged",
            "old": old_version,
            "new": new_version,
        }

    if new_version and new_version != old_version:
        message = f"{pname}: {old_version} -> {new_version}"
    else:
        message = f"{pname}: update sources"

    if dry_run:
        git(root, "checkout", "--", pkg_path)
        return {
            "name": name,
            "status": "would-update",
            "old": old_version,
            "new": new_version,
            "message": message,
        }

    if pr_config is not None:
        branch = f"update-{name}-{new_version or 'sources'}"
        result = open_pr(
            root, pkg_path, branch, message, "Automated update.", maintainers, pr_config
        )
        if result["status"] == "unchanged":
            return {
                "name": name,
                "status": "unchanged",
                "old": old_version,
                "new": new_version,
            }
        if result["status"] == "skipped":
            return {"name": name, **result}
        return {
            "name": name,
            "status": "updated",
            "old": old_version,
            "new": new_version,
            **result,
        }

    if do_commit:
        committed = commit_package(root, pkg_path, message)
        if not committed:
            return {
                "name": name,
                "status": "unchanged",
                "old": old_version,
                "new": new_version,
            }
        return {
            "name": name,
            "status": "updated",
            "old": old_version,
            "new": new_version,
            "committed": True,
            "message": message,
        }

    return {
        "name": name,
        "status": "updated",
        "old": old_version,
        "new": new_version,
        "committed": False,
        "path": pkg_path,
    }


def update_flake_lock(
    root: Path, dry_run: bool, do_commit: bool, pr_config: PrConfig | None
) -> dict:
    if working_tree_dirty(root, "flake.lock"):
        return {
            "status": "skipped",
            "reason": "flake.lock already has uncommitted changes",
        }

    proc = run(["nix", "flake", "update"], cwd=root)
    if proc.returncode != 0:
        return {
            "status": "failed",
            "reason": f"nix flake update exited {proc.returncode}",
        }

    if not working_tree_dirty(root, "flake.lock"):
        return {"status": "unchanged"}

    if dry_run:
        git(root, "checkout", "--", "flake.lock")
        return {"status": "would-update"}

    if pr_config is not None:
        branch = f"flake-lock-update-{dt.date.today().isoformat()}"
        no_reviewers_cfg = PrConfig(
            **{**pr_config.__dict__, "assign_maintainers": False}
        )
        return open_pr(
            root,
            "flake.lock",
            branch,
            "flake.lock: Update",
            "Automated flake input update.",
            maintainers=[],
            cfg=no_reviewers_cfg,
        )

    if do_commit:
        committed = commit_package(root, "flake.lock", "flake.lock: Update")
        return {"status": "committed"} if committed else {"status": "unchanged"}

    return {"status": "updated", "path": "flake.lock"}


# reporting


def report(r: dict) -> None:
    status = r["status"]
    if status == "updated":
        bits = [f"{r.get('old')} -> {r.get('new')}"]
        if r.get("pr_url"):
            bits.append(f"PR: {r['pr_url']}")
            if r.get("reviewers"):
                bits.append(f"reviewers: {', '.join(r['reviewers'])}")
        elif r.get("self_committed"):
            bits.append("[self-committed]")
        elif r.get("committed"):
            bits.append("[committed]")
        else:
            bits.append(f"[not committed -- {r.get('path')}]")
        print("    " + "  ".join(bits))
    elif status == "would-update":
        print(f"    would update {r.get('old')} -> {r.get('new')}: {r['message']}")
    elif status == "unchanged":
        print(f"    already up to date ({r.get('old')})")
    elif status == "skipped":
        print(f"    skipped: {r['reason']}")
    elif status == "failed":
        print(f"    FAILED: {r['reason']}")


def report_flake_lock(r: dict) -> None:
    status = r["status"]
    if status == "pr-opened":
        print(f"    PR: {r['pr_url']}")
    elif status == "committed":
        print("    committed as 'flake.lock: Update'")
    elif status == "updated":
        print(f"    updated, not committed -- {r['path']}")
    elif status == "would-update":
        print("    would update flake.lock")
    elif status == "unchanged":
        print("    inputs already up to date")
    elif status == "skipped":
        print(f"    skipped: {r['reason']}")
    elif status == "failed":
        print(f"    FAILED: {r['reason']}")


def summary(results: list[dict]) -> None:
    print("\n==> summary")
    for status in ("updated", "would-update", "unchanged", "skipped", "failed"):
        matching = [
            r["name"] for r in results if r.get("name") and r["status"] == status
        ]
        if matching:
            print(f"  {status:12s} {', '.join(matching)}")


def build_pr_config(args, root: Path) -> PrConfig:
    kind = args.forge or guess_forge_kind(root)
    token_envs = args.token_env or ["GITHUB_TOKEN", "FORGEJO_TOKEN", "GITEA_TOKEN"]
    token = get_token(token_envs)
    forge_obj = forge_mod.get_forge(kind, token=token, instance_url=args.forge_url)
    owner, repo = remote_owner_repo(root)
    base_branch = args.base_branch or detect_base_branch(root)
    maintainer_attr = args.maintainer_attr or (
        "github" if kind == "github" else "forgejo"
    )
    return PrConfig(
        forge=forge_obj,
        owner=owner,
        repo=repo,
        base_branch=base_branch,
        maintainer_attr=maintainer_attr,
        assign_maintainers=not args.no_assign_maintainers,
    )


def main() -> None:
    parser = argparse.ArgumentParser(
        prog="update-flake-pkgs",
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "packages",
        nargs="*",
        help="package names to update (default: all discovered packages)",
    )
    parser.add_argument(
        "--root", default=".", help="flake root (default: current directory)"
    )
    parser.add_argument(
        "--local-dir",
        help="scan this directory (relative to --root, e.g. 'pkgs') for by-name/category "
        "packages instead of evaluating legacyPackages.<system>",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="run update scripts, report what would happen, but discard all changes",
    )
    parser.add_argument(
        "--list", action="store_true", help="list discovered packages and exit"
    )

    write_group = parser.add_mutually_exclusive_group()
    write_group.add_argument(
        "--commit",
        action="store_true",
        help="commit each update directly to the current branch (default: leave changes uncommitted in the working tree)",
    )
    write_group.add_argument(
        "--pr",
        action="store_true",
        help="open a PR per updated package instead of committing directly",
    )

    pr_group = parser.add_argument_group("PR mode (used with --pr)")
    pr_group.add_argument(
        "--forge",
        choices=["github", "forgejo"],
        help="default: auto-detected from the origin remote",
    )
    pr_group.add_argument(
        "--forge-url",
        help="base URL for a self-hosted forge (required for --forge forgejo)",
    )
    pr_group.add_argument(
        "--token-env",
        action="append",
        help="env var to read the forge API token from (repeatable; default tries GITHUB_TOKEN, FORGEJO_TOKEN, GITEA_TOKEN)",
    )
    pr_group.add_argument(
        "--base-branch", help="PR base branch (default: origin's default branch)"
    )
    pr_group.add_argument(
        "--maintainer-attr",
        help="meta.maintainers field used as the forge username (default: 'github' or 'forgejo' depending on --forge)",
    )
    pr_group.add_argument(
        "--no-assign-maintainers",
        action="store_true",
        help="open PRs without requesting review from meta.maintainers",
    )
    pr_group.add_argument(
        "--update-flake-inputs",
        action="store_true",
        help="also run `nix flake update`; flake.lock changes are handled the same way as package updates (see --commit/--pr)",
    )

    args = parser.parse_args()

    root = Path(args.root).resolve()
    if not (root / "flake.nix").exists():
        sys.exit(f"error: {root} does not look like a flake root (no flake.nix)")

    try:
        all_names = discover_packages(root, args.local_dir)
    except Exception as e:
        sys.exit(f"error: {e}")

    if args.list:
        print("\n".join(all_names))
        return
    if not all_names:
        where = (
            f"--local-dir={args.local_dir}"
            if args.local_dir
            else "legacyPackages.<system>"
        )
        sys.exit(f"error: no packages found via {where}")

    names = args.packages or all_names
    unknown = sorted(set(names) - set(all_names))
    if unknown:
        sys.exit(f"error: unknown package(s): {', '.join(unknown)}")

    pr_config: PrConfig | None = None
    if args.pr:
        try:
            pr_config = build_pr_config(args, root)
        except Exception as e:
            sys.exit(f"error: could not set up PR mode: {e}")
        if not args.dry_run:
            git(root, "switch", pr_config.base_branch, check=True)

    if args.local_dir:
        attribute_prefix = ""
    else:
        try:
            attribute_prefix = f"legacyPackages.{nix_current_system()}."
        except Exception as e:
            sys.exit(f"error: could not resolve current system: {e}")

    results = []
    for name in names:
        print(f"==> {name}", flush=True)
        try:
            result = update_one(
                root, name, attribute_prefix, args.dry_run, args.commit, pr_config
            )
        except Exception as e:
            result = {"name": name, "status": "failed", "reason": str(e)}
        results.append(result)
        report(result)

    if args.update_flake_inputs:
        print("==> flake.lock", flush=True)
        flake_result = update_flake_lock(root, args.dry_run, args.commit, pr_config)
        report_flake_lock(flake_result)

    summary(results)

    if any(r["status"] == "failed" for r in results):
        sys.exit(1)


if __name__ == "__main__":
    main()
