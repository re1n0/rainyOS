_: {
  flake.nixosModules.nix-substituters = {lib, ...}: {
    nix.settings = {
      substituters = lib.mkForce [
        "https://cache.nixos.org"
      ];

      trusted-public-keys = lib.mkForce [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };
}
