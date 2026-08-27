{lib, ...}: {
  options.rainy.settings.bindings = {
    left = lib.mkOption {
      type = lib.types.str;
      default = "H";
    };
    right = lib.mkOption {
      type = lib.types.str;
      default = "L";
    };
    up = lib.mkOption {
      type = lib.types.str;
      default = "K";
    };
    down = lib.mkOption {
      type = lib.types.str;
      default = "J";
    };
  };
}
