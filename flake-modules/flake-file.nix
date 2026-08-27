{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.flake-file.flakeModules.default
    # inputs.flake-file.flakeModules.allfollow
  ];

  flake-file.inputs = {
    # keep-sorted start block=yes newline_separated=yes
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

    git-hooks = {
      type = "github";
      owner = "cachix";
      repo = "git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };

    import-tree = {
      type = "github";
      owner = "denful";
      repo = "import-tree";
    };

    nixpkgs-unstable = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    nixpkgs.follows = "nixpkgs-unstable";

    systems = {
      type = "github";
      owner = "nix-systems";
      repo = "default-linux";
    };
    # keep-sorted end
  };

  flake-file.outputs =
    /*
    nix
    */
    ''
      inputs:
      let
        lib = inputs.nixpkgs.lib;
        mkTarget = import ./lib/mkTarget.nix { inherit lib; };
      in
      inputs.flake-parts.lib.mkFlake {
        inherit inputs;
        specialArgs = { inherit mkTarget; };
      } (
        inputs.import-tree [
          ./flake-modules
          ./modules
        ]
      )
    '';

  flake-file.formatter = pkgs: let
    treefmt = config.flake.formatter.${pkgs.stdenv.hostPlatform.system};
  in
    pkgs.writeShellApplication {
      name = "flake-file-fmt";
      runtimeInputs = [treefmt];
      text = ''
        ${lib.getExe treefmt} --no-cache --tree-root "$(dirname "$1")" "$@"
      '';
    };
}
