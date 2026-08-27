{inputs, ...}: {
  flake-file.inputs.impermanence = {
    type = "github";
    owner = "nix-community";
    repo = "impermanence";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  flake.nixosModules.impermanence = inputs.impermanence.nixosModules.impermanence;
  flake.homeManagerModules.impermanence = inputs.impermanence.homeManagerModules.impermanence;
}
