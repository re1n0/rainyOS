{
  pkgs,
  lib,
  os,
  ...
}:
lib.optionalAttrs os.gui.enable {
  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      evafast
      autodeint
      thumbfast

      mpris

      autoload
      sponsorblock-minimal
      youtube-upnext
      quality-menu

      uosc
    ];

    config = {
      profile = "high-quality";
      hwdec = "auto";

      vo = "gpu-next";

      gpu-api = "vulkan";
      gpu-context = "waylandvk";

      fullscreen = true;

      dither-depth = 8;
      scale-antiring = 0.6;

      deband = false;

      # UI
      osd-bar = false;
      osc = true;

      cursor-autohide = 300;
      osd-level = 1;
      osd-duration = 1000;

      # Audio
      audio-pitch-correction = true;

      # Subtitles
      demuxer-mkv-subtitle-preroll = true;
      sub-auto = "all";

      # HDR
      target-colorspace-hint = true;

      # YouTube
      script-opts = [
        "ytdl_hook-ytdl_path=yt-dlp"
      ];
    };

    scriptOpts.uosc = {
      controls = builtins.concatStringsSep "," [
        "<!has_many_video,video,stream>command:theaters:script-binding quality_menu/video_formats_toggle#@vformats>1?Video"
        "<!has_many_audio,has_audio,stream>command:graphic_eq:script-binding quality_menu/audio_formats_toggle#@aformats>1?Audio"
        "<stream>command:queue_play_next:script-message-to youtube_upnext menu?Up Next"
      ];
    };
  };
}
