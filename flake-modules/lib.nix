{inputs, ...}: {
  flake-file.inputs.home-manager = {
    type = "github";
    owner = "nix-community";
    repo = "home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.nixosModules.home-manager = inputs.home-manager.nixosModules.home-manager;

  flake.lib = {
    mkHost = import ../lib/mkHost.nix {inherit inputs;};
    mkHosts = import ../lib/mkHosts.nix {inherit inputs;};
  };
}
