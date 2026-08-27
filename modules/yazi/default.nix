{mkTarget, ...}:
mkTarget "yazi" {
  tags = ["tui"];
  description = "Yazi terminal file manager";

  hm = {pkgs, ...}: {
    home.packages = with pkgs; [
      # keep-sorted start
      (ouch.override {enableUnfree = true;})
      fd
      ffmpeg
      glib
      glow
      hexyl
      imagemagick
      mediainfo
      pass
      poppler
      ripgrep
      sshfs
      # keep-sorted end
    ];

    programs.yazi = {
      enable = true;
      plugins = with pkgs.yaziPlugins; {
        inherit
          # keep-sorted start
          bypass
          chmod
          clipboard
          mediainfo
          ouch
          piper
          restore
          smart-enter
          sudo
          zoom
          # keep-sorted end
          ;
        git = {
          package = git;
          setup = true;
        };
        gvfs = {
          package = gvfs;
          setup = true;
          settings.password_vault = "pass";
        };
        yafg = {
          package = yafg;
          setup = true;
        };
        sshfs = {
          package = sshfs;
          setup = true;
        };
      };
      initLua = ''
        require("zoxide"):setup {
          update_db = true,
        }
      '';
    };
  };
}
