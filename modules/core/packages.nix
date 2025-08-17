{
  pkgs,
  inputs,
  ...
}:
{
  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    adb.enable = true;
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.package = pkgs.lix;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://chaotic-nyx.cachix.org/"
      "https://nixpkgs-wayland.cachix.org"
      "https://nix-gaming.cachix.org"
    ];

    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (import ../../pkgs)
    inputs.nixpkgs-wayland.overlay
  ];

  environment.pathsToLink = [ "/share/zsh" ];

  services.fwupd.enable = true;
}
