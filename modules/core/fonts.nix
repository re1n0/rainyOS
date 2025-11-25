{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkIf config.rainyos.gui.enable {
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = false;
    enableGhostscriptFonts = false;
    packages = with pkgs; [
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
      nerd-fonts.mononoki
      inter
      wqy_microhei
      azuki
    ];
    fontconfig.defaultFonts = {
      sansSerif = [
        "Inter"
        "wqy-microhei"
        "azuki"
      ];
      serif = config.fonts.fontconfig.defaultFonts.sansSerif;
      monospace = [ "Mononoki Nerd Font" ];
      emoji = [
        "Noto Color Emoji"
        "Noto Emoji"
      ];
    };
  };
}
