{
  pkgs,
  config,
  ...
}:
{
  stylix = {
    inherit (config.rainyos.gui) enable;
    polarity = "dark";
    base16Scheme = "${pkgs.themes}/catppuccin-mocha.yaml";
  };

  stylix.fonts = with pkgs; {
    serif = config.stylix.fonts.sansSerif;

    sansSerif = {
      package = inter;
      name = "Inter";
    };

    monospace = {
      package = nerd-fonts.mononoki;
      name = "Mononoki Nerd Font";
    };

    emoji = {
      package = noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };
  };
}
