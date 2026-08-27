_: {
  flake.nixosModules.compat-tool = {
    lib,
    pkgs,
    ...
  }: {
    options.compatTool.default =
      lib.mkOption
      {
        type = lib.types.nullOr lib.types.package;
        default = pkgs.proton-ge-bin;
      };
  };
  flake.homeManagerModules.compat-tool = {
    lib,
    osConfig ? null,
    ...
  }: {
    options.compatTool.default = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
    };
    config = lib.mkIf (osConfig != null) {
      compatTool.default = osConfig.compatTool.default;
    };
  };
}
