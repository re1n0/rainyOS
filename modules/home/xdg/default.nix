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
    enable = lib.mkForce true;
    xdgOpenUsePortal = true;
    extraPortals =
      with pkgs;
      [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-termfilechooser
      ]
      ++ (if hyprland.enable then [ pkgs.xdg-desktop-portal-hyprland ] else [ ]);
    config = {
      common = {
        default = lib.optional hyprland.enable "hyprland" ++ [
          "termfilechooser"
          "wlr"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    };
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd = ${pkgs.writeShellScript "yazi-wrapper" ''
      #!/usr/bin/env bash
      path="$4"
      out="$5"

      if [ -f "$path" ]; then
        target_dir="$(dirname "$path")"
      elif [ -d "$path" ]; then
        target_dir="$path"
      else
        target_dir="$HOME"
      fi

      exec ghostty -e yazi --chooser-file="$out" "$target_dir"
    ''}
    default_dir = $HOME
    open_mode = suggested
    save_mode = last
  '';
}
