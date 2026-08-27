{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.flake-parts.flakeModules.easyOverlay];

  perSystem = {
    config,
    final,
    pkgs,
    system,
    ...
  }: let
    localPkgNames =
      builtins.attrNames
      (lib.filterAttrs (_: type: type == "directory") (builtins.readDir ../pkgs));
    localPackages =
      lib.genAttrs localPkgNames
      (name: final.callPackage (../pkgs + "/${name}/package.nix") {});

    fromInput = flakeOutput: names:
      lib.optionalAttrs (flakeOutput ? ${system})
      (lib.getAttrs names flakeOutput.${system});
  in {
    packages =
      localPackages
      // fromInput inputs.cachyos-kernel.packages ["linux-cachyos-latest-lto-x86_64-v3"]
      // fromInput inputs.millennium-steam.packages ["close-steam-session" "millennium" "millennium-steam"]
      // fromInput inputs.gaming-edge.packages ["libdrm-git" "libdrm32-git" "mesa-git" "mesa32-git" "proton-cachyos-x86_64-v3" "vintagestory" "wayland-protocols-git"]
      // fromInput inputs.vaultix.packages ["vaultix"]
      // fromInput inputs.steam-config.packages ["steam-config-patcher"];

    legacyPackages =
      fromInput inputs.millennium-steam.legacyPackages ["millenniumPlugins" "millenniumThemes"];

    overlayAttrs = config.packages // config.legacyPackages;

    apps.update = {
      type = "app";
      program = toString (pkgs.writeShellScript "update" ''
        set -euo pipefail
        cd "$(git rev-parse --show-toplevel)"
        for name in ${lib.concatStringsSep " " localPkgNames}; do
          echo "==> $name"
          ${lib.getExe pkgs.nix-update} --flake --use-update-script "$name" \
            || echo "  (no update path for $name, skipping)"
        done
      '');
    };
  };
}
