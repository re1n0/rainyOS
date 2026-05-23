{
  lib,
  pkgs,
  os,
  ...
}:
lib.optionalAttrs os.gaming.steam.enable {
  programs.steam.millenniumConfig = {
    themes.conditions."space-theme-steam" = {
      "Achievement Notification" = "no";
      "Add shelf button" = "no";
      "Always show download bar" = "no";
      "Always show game infos" = "no";
      "Always show sidebar" = "yes";
      "Banner Infos" = "no";
      "Banner position" = "Middle (default)";
      "Big Picture Mode button" = "no";
      "Bigger banner" = "no";
      "Broadcast" = "no";
      "Darken not installed games" = "yes";
      "Digital product info" = "no";
      "Dynamic banner height" = "no";
      "Follow the creators" = "no";
      "Font" = "Be Vietnam Pro (default)";
      "Footer" = "no";
      "Friend icon" = "no";
      "Friend list button" = "no";
      "Game Overlay" = "yes";
      "Game cover shiny effect" = "no";
      "Game info box artwork" = "no";
      "Hide group chat" = "no";
      "Info sidebar on right" = "no";
      "Landing Header" = "no";
      "Mica & Acrylic plugin support" = "no";
      "Navigation buttons" = "no";
      "News button" = "no";
      "Notification button" = "no";
      "Playbar in Banner" = "no";
      "Profile pages header" = "no";
      "Recommendations" = "no";
      "Scrollbars" = "no";
      "Sidebar on left" = "no";
      "Sidebar on right" = "no";
      "Sidebar only on hover" = "no";
      "Steam VR button" = "no";
      "Steam-Custom-Artworks Support" = "no";
      "System accent colors" = "no";
      "URL bar" = "no";
      "VAC-Ban visibility" = "Show";
      "Wallet balance" = "no";
      "What's New" = "Compact";
      "Window Controls" = "Hide";
      "Write a Review" = "no";
    };
  };

  programs.steam.plugins = with pkgs.millenniumPlugins; [
    extendium
    gratitude
    # hltb
    non-steam-playtimes
    # browser-history
  ];
}
