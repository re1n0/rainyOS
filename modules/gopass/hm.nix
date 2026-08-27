_: {
  flake.homeManagerModules.gopass = {
    config,
    lib,
    pkgs,
    ...
  }: let
    iniFormat = pkgs.formats.gitIni {};
    cfg = config.programs.gopass;
  in {
    options.programs.gopass = {
      enable = lib.mkEnableOption "Enable gopass password manager";
      config = lib.mkOption {
        type = lib.types.submodule {
          freeformType = iniFormat.type;
        };
        description = "gopass configuration";
      };
    };

    config = lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        gopass
        gopass-hibp
      ];

      programs.gopass.config.mounts.path = lib.mkDefault config.xdg.dataHome + "/password-store";

      xdg.configFile."gopass/config".text = iniFormat.generate "gopass-config" cfg.config;
    };
  };
}
