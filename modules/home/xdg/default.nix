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
      multiple="$1"
      directory="$2"
      save="$3"
      path="$4"
      out="$5"
      debug="$6"

      set -e

      if [ "$debug" = 1 ]; then
          set -x
      fi

      if [ "$save" = "1" ]; then
          # save a file
          set -- --chooser-file="$out" "$path"
      elif [ "$directory" = "1" ]; then
          # upload files from a directory
          set -- --chooser-file="$out" --cwd-file="$out"".1" "$path"
      elif [ "$multiple" = "1" ]; then
          # upload multiple files
          set -- --chooser-file="$out" "$path"
      else
          # upload only 1 file
          set -- --chooser-file="$out" "$path"
      fi

      exec ghostty -e yazi "$@"

      if [ "$directory" = "1" ]; then
          if [ ! -s "$out" ] && [ -s "$out"".1" ]; then
              cat "$out"".1" > "$out"
              rm "$out"".1"
          else
              rm "$out"".1"
          fi
      fi
    ''}
    default_dir = $HOME
    open_mode = suggested
    save_mode = last
  '';
}
