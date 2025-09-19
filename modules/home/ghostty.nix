{ lib
, os
, ...
}:
lib.optionalAttrs os.gui.enable {
  programs.ghostty = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      font-family = [
        ""
        "Mononoki Nerd Font"
        "Noto Emoji"
        "azuki_font"
      ];

      font-size = 14;

      window-decoration = "none";
      window-padding-x = 10;

      app-notifications = [ "no-clipboard-copy" ];

      shell-integration-features = [
        "sudo"
        "title"
        "ssh-env"
        "ssh-terminfo"
      ];

      quit-after-last-window-closed = true;
      quit-after-last-window-closed-delay = "5s";
    };
  };
}
