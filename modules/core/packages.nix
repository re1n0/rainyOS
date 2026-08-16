{
  inputs,
  self,
  lib,
  ...
}: {
  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      "nixos-millennium.cachix.org-1:AaMK3uqfgzCUpjs7+gdHTwwaqkT/vvLMCnUKSY37QAQ="
      "nixos-rocksmith.cachix.org-1:gg6dJg9svbP30JVrtFwkCpGVBkHbEwYswGS2VoXJ2qo="
      "tokidoki:MD4VWt3kK8Fmz3jkiGoNRJIW31/QAm7l1Dcgz2Xa4hk="
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://chaotic-nyx.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://hyprland.cachix.org"
      "https://attic.xuyh0120.win/lantian"
      "https://nixos-millennium.cachix.org"
      "https://nixos-rocksmith.cachix.org"
      "https://nix-cache.tokidoki.dev/tokidoki"
    ];

    auto-optimise-store = true;
  };

  services.gvfs.enable = true;

  nixpkgs.overlays = [
    self.overlays.default
    inputs.nix-cachyos-kernel.overlays.pinned
    inputs.mesa-git.overlays.default
    inputs.nix-gaming-edge.overlays.default
    inputs.nixos-millennium.overlays.default
    inputs.nixos-rocksmith.overlays.default
    inputs.nix-gaming.overlays.default
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "azuki"
      "evafast"
      "nvidia-x11"
      "nvidia-settings"
      "ouch"
      "steam"
      "steam-unwrapped"
      "youtube-upnext"
      "win-sdk"
      "xwin-fetch-msvc"
    ];

  nixpkgs.config.microsoftVisualStudioLicenseAccepted = true;

  services.fwupd.enable = true;

  # system.replaceDependencies.replacements = [
  #   {
  #     oldDependency = pkgs.xdg-utils;
  #     replacement = pkgs.xdg-utils.overrideAttrs (
  #       _:
  #       let
  #         handlr-open = pkgs.writeShellScriptBin "xdg-open" ''${pkgs.handlr-regex}/bin/handlr open -- "$@"'';
  #       in
  #       {
  #         postInstall = ''
  #           cp ${handlr-open}/bin/xdg-open $out/bin/xdg-open
  #         '';
  #       }
  #     );
  #   }

  #   {
  #     oldDependency = pkgs.xterm;
  #     replacement = pkgs.writeShellApplication {
  #       name = "xterm";
  #       runtimeInputs = [ pkgs.handlr-regex ];
  #       text = ''
  #         handlr launch x-scheme-handler/terminal -- "$@"
  #       '';
  #     };
  #   }
  # ];
}
