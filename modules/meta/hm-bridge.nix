_: {
  flake.homeManagerModules.meta-bridge = {
    lib,
    osConfig ? null,
    ...
  }: {
    config = lib.mkIf (osConfig != null) {
      meta.enable = osConfig.meta.enable;
      meta.disable = osConfig.meta.disable;
    };
  };
}
