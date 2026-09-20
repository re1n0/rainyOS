{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gopass
    gopass-hibp
    pass
  ];

  home.sessionVariables.PASSWORD_STORE_DIR = config.xdg.dataHome + "/password-store";

  xdg.configFile."gopass/config".text = lib.generators.toGitINI {
    mounts.path = config.xdg.dataHome + "/password-store";
  };
}
