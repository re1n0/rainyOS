{self, ...}: {
  flake.nixosModules.overlays = {lib, ...}: {
    nixpkgs.overlays = lib.mkForce [
      self.overlays.default
    ];
  };
}
