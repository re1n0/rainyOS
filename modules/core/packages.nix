{
  inputs,
  ...
}:
{
  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
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
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://chaotic-nyx.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.garnix.io"
    ];

    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (import ../../pkgs)
    inputs.nix-cachyos-kernel.overlay
    inputs.proton-cachyos.overlays.default
  ];

  environment.pathsToLink = [ "/share/zsh" ];

  services.fwupd.enable = true;
}
