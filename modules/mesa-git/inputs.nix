{inputs, ...}: {
  flake-file.inputs = {
    gaming-edge = {
      type = "github";
      owner = "powerofthe69";
      repo = "nix-gaming-edge";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.nixosModules.mesa-git = inputs.gaming-edge.nixosModules.mesa-git;
}
