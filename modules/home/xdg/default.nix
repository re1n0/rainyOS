{
  pkgs,
  lib,
  os,
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
      env = ''
        TERMCMD=${lib.getExe pkgs.xterm} --title="filechooser" -e
        PATH="$PATH:/run/current-system/sw/bin"
      '';
      create_help_file = 1;
      default_dir = "$HOME";
      open_mode = "suggested";
      save_mode = "last";
    };
  };
}
