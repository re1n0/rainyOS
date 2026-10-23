{
  pkgs,
  config,
  ...
}: {
  stylix = {
    enable = true;
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

  stylix.icons = {
    enable = true;

    package = pkgs.papirus-icon-theme;

    dark = "Papirus-Dark";
    light = "Papirus-Light";
  };

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";

    size = 32;
  };
}
