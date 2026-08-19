{
  pkgs,
  lib,
  os,
  config,
  ...
}: let
  mimeApps = import ./mimeapps.nix;
  desktopEntries = import ./apps.nix;
  inherit (os.gui) hyprland;
in {
  imports = [./handlr.nix];
  xdg = {
    enable = true;
    userDirs.enable = true;

    inherit mimeApps desktopEntries;
  };

  xdg.portal = lib.mkIf os.gui.enable {
    enable = lib.mkForce true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs;
      [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-termfilechooser
      ]
      ++ (
        if hyprland.enable
        then [pkgs.xdg-desktop-portal-hyprland]
        else []
      );
    config = {
      common = {
        default =
          lib.optional hyprland.enable "hyprland"
          ++ [
            "termfilechooser"
            "wlr"
            "gtk"
          ];
        "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
      };
    };
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = lib.generators.toINI {} {
    filechooser = {
      cmd = "${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh";
      default_dir = config.home.homeDirectory;
      env = ''
        TERMCMD=${lib.getExe pkgs.xterm} --title="filechooser" -e
      '';
      create_help_file = 1;
      open_mode = "suggested";
      save_mode = "last";
    };
  };
}
