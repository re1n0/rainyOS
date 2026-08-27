_: {
  flake.homeManagerModules.meta = {lib, ...}: {
    options.meta = {
      enable = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      disable = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
    };
  };
}
