{inputs, ...}: {
  flake-file.inputs.vaultix = {
    type = "github";
    owner = "milieuim";
    repo = "vaultix";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-parts.follows = "flake-parts";
    inputs.pre-commit-hooks.follows = "git-hooks";
  };

  flake.nixosModules.vaultix = inputs.vaultix.nixosModules.default;
}
