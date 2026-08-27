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
    localPkgNames = let
      pkgsDir = ../pkgs;
      entries = builtins.readDir pkgsDir;
    in
      builtins.attrNames (lib.filterAttrs (
          name: type:
            type
            == "directory"
            && name != "development"
            && builtins.pathExists (pkgsDir + "/${name}/package.nix")
        )
        entries);

    localFlatPackages =
      lib.genAttrs localPkgNames
      (name: final.callPackage (../pkgs + "/${name}/package.nix") {});

    developmentScopeFor = devType:
      if devType == "python-modules"
      then final.python3Packages
      else final;

    developmentDir = ../pkgs/development;
    developmentTypeNames =
      if builtins.pathExists developmentDir
      then
        builtins.attrNames
        (lib.filterAttrs (_: type: type == "directory") (builtins.readDir developmentDir))
      else [];
    developmentPackages =
      lib.foldl' (
        acc: devType: let
          typeDir = developmentDir + "/${devType}";
          scope = developmentScopeFor devType;
          pkgNames =
            builtins.attrNames
            (lib.filterAttrs (_: type: type == "directory") (builtins.readDir typeDir));
          hasDefault = name: builtins.pathExists (typeDir + "/${name}/default.nix");
        in
          acc
          // lib.genAttrs (builtins.filter hasDefault pkgNames)
          (name: scope.callPackage (typeDir + "/${name}") {})
      ) {}
      developmentTypeNames;

    localPackages = localFlatPackages // developmentPackages;

    fromInput = flakeOutput: names:
      lib.optionalAttrs (flakeOutput ? ${system})
      (lib.getAttrs names flakeOutput.${system});
  in {
    legacyPackages =
      localPackages
      // fromInput inputs.cachyos-kernel.legacyPackages ["linux-cachyos-bore-lto-x86_64-v3"]
      // {cachyosHelpers = final.callPackage (inputs.cachyos-kernel + "/helpers.nix") {};}
      // (inputs.hyprland.packages.${system} or {})
      // fromInput inputs.millennium-steam.packages ["close-steam-session" "millennium" "millennium-steam"]
      // fromInput inputs.gaming-edge.packages [
        # keep-sorted start
        "libdrm-git"
        "libdrm32-git"
        "mesa-cache-cleanup"
        "mesa-git"
        "mesa32-git"
        "proton-cachyos-x86_64-v3"
        "steam-cleanup"
        "wayland-protocols-git"
        # keep-sorted end
      ]
      // fromInput inputs.vaultix.packages ["vaultix"]
      // fromInput inputs.steam-config.packages ["steam-config-patcher"]
      // fromInput inputs.glide.packages ["glide-browser-bin-unwrapped" "glide-browser-bin"]
      // fromInput inputs.millennium-steam.legacyPackages ["millenniumPlugins" "millenniumThemes"]
      // {firefoxAddons = inputs.firefox-addons.packages.${system} or {};};

    overlayAttrs = config.legacyPackages;

    apps.update = {
      type = "app";
      program = toString (pkgs.writeShellScript "update" ''
        set -euo pipefail
        cd "$(git rev-parse --show-toplevel)"
        for name in ${lib.concatStringsSep " " localPkgNames}; do
          echo "==> $name"
          ${lib.getExe pkgs.nix-update} --use-update-script "$name" \
            || echo "  (no update path for $name, skipping)"
        done
      '');
    };
  };
}
