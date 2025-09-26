{
  pkgs,
  lib,
  os,
  ...
}:
let
  mimeApps = import ./mimeapps.nix;
  desktopEntries = import ./apps.nix;
  inherit (os.gui) hyprland;
in
{
  imports = [ ./handlr.nix ];
  xdg = {
    userDirs.enable = true;

    inherit mimeApps desktopEntries;
  };

  xdg.portal = lib.mkIf os.gui.enable {
    enable = true;
    extraPortals =
      with pkgs;
      [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ]
      ++ (if hyprland.enable then [ xdg-desktop-portal-hyprland ] else [ ]);
    configPackages = if hyprland.enable then [ pkgs.hyprland ] else [ ];
  };
}
