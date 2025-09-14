{ lib
, os
, pkgs
, ...
}:
let
  settings = import ./settings.nix os;
in
lib.optionalAttrs os.gui.hyprland.enable {
  home.packages = with pkgs; [
    brightnessctl
    hyprpolkitagent
    wl-clipboard
    screenshot
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    plugins = with pkgs.hyprlandPlugins; [
      # hypr-dynamic-cursors
    ];

    inherit settings;
  };

  home.pointerCursor.hyprcursor.enable = true;
}
