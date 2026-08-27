{lib, ...}: {
  options.flake.homeManagerModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = {};
    description = "Home Manager modules.";
  };
}
