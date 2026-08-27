{lib, ...}: {
  options.flake.targetMeta = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        tags = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
        };
        description = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
      };
    });
    default = {};
  };
}
