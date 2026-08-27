_: {
  flake.homeManagerModules.persist = {
    config,
    lib,
    ...
  }: {
    options.persist = {
      root = lib.mkOption {
        type = lib.types.str;
        default = "/persist";
      };
      directories = lib.mkOption {
        type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
        default = [];
      };
      files = lib.mkOption {
        type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
        default = [];
      };
    };

    config = lib.mkIf (config.persist.directories != [] || config.persist.files != []) {
      home.persistence.${config.persist.root} = {
        directories = config.persist.directories;
        files = config.persist.files;
        allowOther = true;
      };
    };
  };
}
