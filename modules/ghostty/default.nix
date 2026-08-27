{mkTarget, ...}:
mkTarget "ghostty" {
  tags = ["gui"];
  description = "Ghostty terminal emulator";

  hm = _: {
    programs.ghostty = {
      enable = true;
      clearDefaultKeybinds = true;
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
        app-notifications = ["no-clipboard-copy"];
        shell-integration-features = [
          "sudo"
          "title"
          "ssh-terminfo"
          "ssh-env"
        ];
        quit-after-last-window-closed = true;
        quit-after-last-window-closed-delay = "5s";
      };
    };

    xdg.mimeApps.defaultApllications = let
      app = "com.mitchellh.ghostty.desktop";
    in {
      "x-scheme-handler/terminal" = app;
      "application/x-sh" = app;
      "application/x-shellscript" = app;
      "x-scheme-handler/kitty" = app;
      "x-scheme-handler/ssh" = app;
    };
  };
}
