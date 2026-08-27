_: {
  flake-file.inputs = {
    hyprland = {
      type = "github";
      owner = "hyprwm";
      repo = "hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
      inputs.pre-commit-hooks.follows = "git-hooks";
    };
  };
}
