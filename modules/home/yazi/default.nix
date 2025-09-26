{
  pkgs,
  ...
}:
let
  keymap = import ./keymap.nix;
  settings = import ./settings.nix;
in
{
  home.packages = with pkgs; [
    fd
    ripgrep

    ffmpeg
    imagemagick
    mediainfo
    poppler
    resvg

    glow
    hexyl

    (ouch.override { enableUnfree = true; })
  ];

  programs.yazi = {
    inherit keymap settings;
    enable = true;

    enableZshIntegration = true;
    shellWrapperName = "lf";

    plugins = with pkgs.yaziPlugins; {
      inherit
        bypass
        chmod
        git
        glow
        mediainfo
        ouch
        piper
        smart-enter
        sudo
        starship
        ;
    };

    initLua = # lua
      ''
        require("git"):setup()
        require("zoxide"):setup {
        	update_db = true,
        }
        require("starship"):setup()
      '';
  };
}
