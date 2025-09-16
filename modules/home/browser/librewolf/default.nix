{ pkgs
, inputs
, config
, os
, ...
}:
let
  inherit (config.home) username;
  settings = import ./settings.nix (builtins.any (m: m.hdr) os.gui.monitors);
  search = import ./search.nix;
  userChrome = (import ../userChrome.nix pkgs).css;
in
{
  programs.librewolf = {
    enable = true;

    package = pkgs.librewolf.override {
      hasMozSystemDirPatch = true;
    };

    nativeMessagingHosts = with pkgs; [
      ff2mpv-rust
      gopass-jsonapi
      tridactyl-native
    ];

    profiles.${username} = {
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        canvasblocker
        clearurls
        consent-o-matic
        fastforwardteam
        ff2mpv
        gopass-bridge
        libredirect
        localcdn
        privacy-badger
        return-youtube-dislikes
        shiori
        sponsorblock
        steam-database
        stylus
        to-deepl
        tridactyl
        ublock-origin
        unpaywall
        user-agent-string-switcher
        web-archives
        youtube-nonstop
      ];

      inherit search userChrome;
    };

    inherit settings;
  };

  stylix.targets.librewolf.profileNames = [ "${username}" ];
}
