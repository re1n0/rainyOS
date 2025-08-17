{ lib, os, ... }:
lib.optionalAttrs os.gui.enable {
  programs.zathura = {
    enable = true;
    options = {
      recolor = false;
      selection-clipboard = "clipboard";
      statusbar-home-tilde = true;
      window-title-basename = true;
    };
  };
}
