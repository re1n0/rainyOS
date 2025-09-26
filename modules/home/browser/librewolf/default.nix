{
  pkgs,
  inputs,
  config,
  os,
  lib,
  ...
}:
let
  inherit (config.home) username;
  settings = import ./settings.nix (builtins.any (m: m.hdr) os.gui.monitors);
  search = import ./search.nix;
  extensionSettings = import ./extensionSettings.nix;
  userChrome = (import ../userChrome.nix pkgs).css;
  mkAutoconfigJs =
    prefs:
    lib.concatStrings (
      lib.mapAttrsToList (name: value: ''
        lockPref("${name}", ${builtins.toJSON value}); 
      '') prefs
    );
in
{
  programs.librewolf = {
    enable = true;

    package = pkgs.librewolf.override {
      hasMozSystemDirPatch = true;
      extraPrefs = mkAutoconfigJs settings;
    };

    nativeMessagingHosts = with pkgs; [
      ff2mpv-rust
      gopass-jsonapi
      tridactyl-native
    ];

    profiles.${username} = {
      extensions = {
        packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          (canvasblocker.override { private_browsing = true; })
          (clearurls.override { private_browsing = true; })
          consent-o-matic
          fastforwardteam
          ff2mpv
          (foxyproxy-standard.override { private_browsing = true; })
          github-file-icons
          gopass-bridge
          libredirect
          localcdn
          return-youtube-dislikes
          shiori
          sponsorblock
          steam-database
          stylus
          to-deepl
          tridactyl
          (ublock-origin.override { private_browsing = true; })
          unpaywall
          (user-agent-string-switcher.override { private_browsing = true; })
          web-archives
        ];

        force = true;

        settings = extensionSettings;
      };

      containersForce = true;

      inherit search userChrome;
    };
  };

  stylix.targets.librewolf = {
    profileNames = [ "${username}" ];
    colorTheme.enable = true;
  };
}
