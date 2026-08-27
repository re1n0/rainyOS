{inputs, ...}: {
  flake-file.inputs = {
    rocksmith2014 = {
      type = "github";
      owner = "re1n0";
      repo = "nixos-rocksmith";
      ref = "release";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
    };
  };

  flake.nixosModules.rocksmith2014-patch = inputs.rocksmith2014.nixosModules.default;
}
