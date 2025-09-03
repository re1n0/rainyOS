{ lib
, os
, ...
}:
lib.optionalAttrs os.gui.enable {
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 14;

      initial_window_width = "95c";
      initial_window_height = "35c";
      window_padding_width = 10;
      confirm_os_window_close = 0;

      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";

      shell_integration = "inherited";
      remote_kitty = "if-needed";
    };
  };
}
