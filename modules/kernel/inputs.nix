_: {
  flake-file.inputs = {
    cachyos-kernel = {
      type = "github";
      owner = "xddxdd";
      repo = "nix-cachyos-kernel";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.flake-compat.follows = "flake-compat";
    };
  };
}
