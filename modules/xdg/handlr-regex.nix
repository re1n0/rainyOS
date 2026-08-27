_: {
  flake.homeManagerModules.handlr-regex = {
    config,
    lib,
    pkgs,
    ...
  }: let
    tomlFormat = pkgs.formats.toml {};
    cfg = config.programs.handlr-regex;
  in {
    options.programs.handlr-regex = {
      enable = lib.mkEnableOption "Enable handlr-regex";
      config = lib.mkOption {
        type = lib.types.submodule {
          freeformType = tomlFormat.type;
        };
        description = "handlr configuration";
      };
    };

    config = lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        handlr-regex
      ];

      programs.handlr-regex.config.enable_selector = lib.mkDefault false;

      xdg.configFile."handlr/default-config.toml".source = tomlFormat.generate "handlr.toml" cfg.config;
    };
  };
}
