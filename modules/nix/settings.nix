_: {
  flake.nixosModules.nix-settings = _: {
    nix.settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      builders-use-substitutes = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
