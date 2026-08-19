{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.rainyos.gui;
in
  lib.mkIf cfg.enable {
    services.displayManager.sessionPackages = [
      (pkgs.writeTextFile {
        name = "hyprland-session";
        destination = "/share/wayland-sessions/hyprland.desktop";
        text = ''
          [Desktop Entry]
          Name=Hyprland
          Comment=An intelligent dynamic tiling Wayland compositor
          Exec=start-hyprland
          DesktopNames=Hyprland
          Type=Application
        '';
        passthru.providedSessions = ["hyprland"];
      })
    ];

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.tuigreet} --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions -t --time-format '%I:%M %p | %a • %h | %F' -g 'Access is restricted to authorized personel only.'";
        };
      };
    };
  }
