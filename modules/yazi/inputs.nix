{inputs, ...}: {
  flake-file.inputs = {
    xdp-termfilepickers = {
      type = "github";
      owner = "Guekka";
      repo = "xdg-desktop-portal-termfilepickers";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  flake.nixosModules.xdp-termfilepickers = inputs.xdp-termfilepickers.homeManagerModules.default;
}
