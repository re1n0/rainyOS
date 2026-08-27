{lib}: name: {
  tags ? [],
  description ? "",
  nixos ? null,
  hm ? null,
}: let
  wrap = cfg: args @ {
    config,
    lib,
    ...
  }: let
    active = lib.subtractLists config.rainy.meta.disable config.rainy.meta.enable;
    autoEnable = tags != [] && lib.all (t: builtins.elem t active) tags;
    resolved =
      if builtins.isFunction cfg
      then cfg args
      else cfg;
  in {
    options.rainy.target.${name}.enable = lib.mkOption {
      type = lib.types.bool;
      default = autoEnable;
    };
    config = lib.mkIf config.rainy.target.${name}.enable resolved;
  };
in {
  flake =
    {targetMeta.${name} = {inherit tags description;};}
    // lib.optionalAttrs (nixos != null) {nixosModules.${name} = wrap nixos;}
    // lib.optionalAttrs (hm != null) {homeManagerModules.${name} = wrap hm;};
}
