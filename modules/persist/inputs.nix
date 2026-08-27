{inputs, ...}: {
  flake-file.inputs.impermanence = {
    type = "github";
    owner = "nix-community";
    repo = "impermanence";
    inputs.nixpkgs.follows = "";
    inputs.home-manager.follows = "";
  };

  flake.nixosModules.impermanence = inputs.impermanence.nixosModules.impermanence;
  flake.homeManagerModules.impermanence = inputs.impermanence.homeManagerModules.impermanence;
}
