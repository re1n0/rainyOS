{
  lib,
  pkgs,
  os,
  ...
}:
lib.optionalAttrs os.gaming.steam.enable {
  programs.steam.millenniumConfig = {
    themes.conditions."adwaita-for-steam" = {
      "Login QR code" = "Show";
      "Keep pointer cursor for clickable elements" = "yes";
      "Remove rounded corners" = "yes";
      "Show Library sidebar on hover" = "no";
      "Show URL" = "yes";
      "Window controls layout" = "Adwaita";
      "Window controls theme" = "Adwaita (GNOME)";
    };
  };

  programs.steam.plugins = with pkgs.millenniumPlugins; [
    extendium
    gratitude
    # hltb
    non-steam-playtimes
    browser-history
  ];
}
