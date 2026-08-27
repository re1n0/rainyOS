# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: let
    lib = inputs.nixpkgs.lib;
    mkTarget = import ./lib/mkTarget.nix {inherit lib;};
  in
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = {inherit mkTarget;};
    } (
      inputs.import-tree [
        ./flake-modules
        ./modules
      ]
    );

  inputs = {
    cachyos-kernel = {
      type = "github";
      owner = "xddxdd";
      repo = "nix-cachyos-kernel";
      ref = "release";
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    flake-compat = {
      type = "github";
      owner = "NixOS";
      repo = "flake-compat";
    };
    flake-file = {
      type = "github";
      owner = "denful";
      repo = "flake-file";
    };
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    gaming-edge = {
      type = "github";
      owner = "powerofthe69";
      repo = "nix-gaming-edge";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks = {
      type = "github";
      owner = "cachix";
      repo = "git-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      type = "github";
      owner = "nix-community";
      repo = "impermanence";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    import-tree = {
      type = "github";
      owner = "denful";
      repo = "import-tree";
    };
    millennium-steam = {
      type = "github";
      owner = "re1n0";
      repo = "nixos-millennium";
      ref = "release";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    nixpkgs.follows = "nixpkgs-unstable";
    nixpkgs-unstable = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    rocksmith2014 = {
      type = "github";
      owner = "re1n0";
      repo = "nixos-rocksmith";
      ref = "release";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    steam-config = {
      type = "github";
      owner = "different-name";
      repo = "steam-config-nix";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    systems = {
      type = "github";
      owner = "nix-systems";
      repo = "default-linux";
    };
    vaultix = {
      type = "github";
      owner = "milieuim";
      repo = "vaultix";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "git-hooks";
      };
    };
    xdp-termfilepickers = {
      type = "github";
      owner = "Guekka";
      repo = "xdg-desktop-portal-termfilepickers";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
