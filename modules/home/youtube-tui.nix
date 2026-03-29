{
  pkgs,
  lib,
  os,
}:
lib.optionalAttrs os.gui.enable {
  home.packages = with pkgs; [
    youtube-tui
  ];

  xdg.configFile."youtube-tui/main.yaml".text = lib.generators.toINIWithGlobalSection { } {
    mouse_support = true;

    invidious_instance = "https://yewtu.be";

    write_config = "Dont";

    allow_unicode = true;

    refresh_after_modifying_search_filters = true;

    syncing = {
      download_images = true;
      sync_channel_info = true;
      sync_channel_cooldown_secs = 86400;
      sync_videos_cooldown_secs = 600;
    };

    limits = {
      watch_history = 50;
      search_history = 75;
      commands_history = 75;
    };

    textbar_scroll_behaviour = "Word";

    image_index = 4;

    provider = "YouTube";
    search_provider = "RustyPipe";

    shell = "zsh";

    legacy_input_handling = false;

    env = {
      video-player = "mpv";

      download-path = "~/Downloads/%(title)s-%(id)s.%(ext)s";
      save-path = "~/.local/share/youtube-tui/saved/";

      terminal-emulator = "xterm -e";

      youtube-downloader = "yt-dlp";

      browser = "xdg-open";
    };
  };
}
