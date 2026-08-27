from __future__ import annotations

from dataclasses import dataclass


class ForgeError(RuntimeError):
    pass


@dataclass
class PullRequest:
    number: int
    url: str


class Forge:
    """Interface implemented by GitHubForge and ForgejoForge."""

    def create_pr(
        self, owner: str, repo: str, *, title: str, body: str, head: str, base: str
    ) -> PullRequest:
        raise NotImplementedError

    def request_reviewers(
        self, owner: str, repo: str, pr: PullRequest, usernames: list[str]
    ) -> None:
        raise NotImplementedError


class GitHubForge(Forge):
    def __init__(self, token: str, api_base: str = "https://api.github.com") -> None:
        from github import Auth, Github

        self._gh = Github(base_url=api_base, auth=Auth.Token(token))

    def create_pr(
        self, owner: str, repo: str, *, title: str, body: str, head: str, base: str
    ) -> PullRequest:
        from github import GithubException

        try:
            repository = self._gh.get_repo(f"{owner}/{repo}")
            pr = repository.create_pull(base=base, head=head, title=title, body=body)
        except GithubException as e:
            raise ForgeError(str(e)) from e
        return PullRequest(number=pr.number, url=pr.html_url)

    def request_reviewers(
        self, owner: str, repo: str, pr: PullRequest, usernames: list[str]
    ) -> None:
        if not usernames:
            return
        from github import GithubException

        try:
            repository = self._gh.get_repo(f"{owner}/{repo}")
            repository.get_pull(pr.number).create_review_request(reviewers=usernames)
        except GithubException as e:
            raise ForgeError(str(e)) from e


class ForgejoForge(Forge):
    def __init__(self, instance_url: str, token: str) -> None:
        from pyforgejo import PyforgejoApi

        self._client = PyforgejoApi(
            base_url=f"{instance_url.rstrip('/')}/api/v1", api_key=token
        )

    def create_pr(
        self, owner: str, repo: str, *, title: str, body: str, head: str, base: str
    ) -> PullRequest:
        from pyforgejo.core.api_error import ApiError

        try:
            pr = self._client.repository.repo_create_pull_request(
                owner,
                repo,
                title=title,
                body=body,
                head=head,
                base=base,
            )
        except ApiError as e:
            raise ForgeError(str(e)) from e
        return PullRequest(number=pr.number, url=pr.html_url)

    def request_reviewers(
        self, owner: str, repo: str, pr: PullRequest, usernames: list[str]
    ) -> None:
        if not usernames:
            return
        from pyforgejo.core.api_error import ApiError

        try:
            self._client.repository.repo_create_pull_review_requests(
                owner,
                repo,
                pr.number,
                reviewers=usernames,
            )
        except ApiError as e:
            raise ForgeError(str(e)) from e


def get_forge(kind: str, *, token: str, instance_url: str | None = None) -> Forge:
    if kind == "github":
        return GitHubForge(token, api_base=instance_url or "https://api.github.com")
    if kind == "forgejo":
        if not instance_url:
            raise ForgeError("forgejo forge requires --forge-url")
        return ForgejoForge(instance_url, token)
    raise ForgeError(f"unknown forge: {kind}")
