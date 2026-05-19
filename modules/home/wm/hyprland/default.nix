{
  lib,
  os,
  pkgs,
  ...
}:
let
  nixVars = import ./settings.nix { inherit lib os pkgs; };
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

    configType = "lua";

    plugins = with pkgs.hyprlandPlugins; [
      # hypr-dynamic-cursors
    ];

    extraLuaFiles = {
      "00-nix-vars" = nixVars;
      binds = ./binds.lua;
      settings = ./settings.lua;
    };
  };

  home.pointerCursor.hyprcursor.enable = true;

  stylix.targets.hyprland.enable = false;
}
