_: {
  flake.nixosModules.lix = {pkgs, ...}: {
    nix.package = pkgs.lixPackageSets.stable.lix;

    nixpkgs.overlays = [
      (_prev: final: {
        inherit
          (final.lixPackageSets.stable)
          nixpkgs-review
          nix-eval-jobs
          nix-fast-build
          colmena
          ;
      })
    ];
  };
}
