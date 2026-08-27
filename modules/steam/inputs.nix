{
  inputs,
  lib,
  ...
}: {
  flake-file.inputs = {
    millennium-steam = {
      type = "github";
      owner = "re1n0";
      repo = "nixos-millennium";
      ref = "release";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
    };
    gaming-edge = {
      type = "github";
      owner = "powerofthe69";
      repo = "nix-gaming-edge";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    steam-config = {
      type = "github";
      owner = "different-name";
      repo = "steam-config-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
    };
  };

  flake.homeManagerModules = {
    steam-config = inputs.steam-config.homeModules.default;
    steam-alias = lib.mkAliasOptionModule ["steam"] ["programs" "steam" "config"];
  };
  flake.nixosModules.millennium-steam = inputs.millennium-steam.nixosModules.default;
}
