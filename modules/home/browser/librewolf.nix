{
  pkgs,
  inputs,
  config,
  ...
}:
let
  inherit (config.home) username;
  userChrome = import ./userChrome.nix pkgs;
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

    settings = {
      "accessibility.force_disabled" = 1;

      "app.normandy.first_run" = false;
      "app.normandy.api_url" = "";
      "app.normandy.enabled" = false;

      "app.shield.optoutstudies.enabled" = false;

      "app.update.channel" = "default";

      "browser.aboutConfig.showWarning" = false;

      "browser.display.use_document_fonts" = 0;

      "browser.discovery.enabled" = false;
      "browser.helperApps.deleteTempFileOnExit" = true;

      "browser.translations.enable" = false;
      "browser.translations.automaticallyPopup" = false;
      "browser.translations.select.enable" = false;

      "browser.urlbar.quickactions.enabled" = false;
      "browser.urlbar.quickactions.showPrefs" = false;
      "browser.urlbar.shortcuts.quickactions" = false;
      "browser.urlbar.suggest.quickactions" = false;

      "browser.toolbars.bookmarks.visibility" = "newtab";

      "dom.forms.autocomplete.formautofill" = false;

      "extensions.update.enabled" = false;
      "extensions.webcompat.enable_picture_in_picture_overrides" = true;
      "extensions.webcompat.enable_shims" = true;
      "extensions.webcompat.perform_injections" = true;
      "extensions.webcompat.perform_ua_overrides" = true;
      "extensions.autoDisableScopes" = 0;

      "gfx.webrender.all" = true;

      "media.ffmpeg.vaapi.enabled" = true;

      "network.connectivity-service.enabled" = false;

      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.sanitize.sanitizeOnShutdown" = false;

      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
      "privacy.clearOnShutdown_v2.cache" = false;

      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

      "webgl.disabled" = false;

      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "widget.use-xdg-desktop-portal.mime-handler" = 1;
      "widget.use-xdg-desktop-portal.settings" = 1;
      "widget.use-xdg-desktop-portal.open-uri" = 1;
    };

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
        stylus
        to-deepl
        tridactyl
        ublock-origin
        unpaywall
        user-agent-string-switcher
        web-archives
        youtube-nonstop
      ];

      search = {
        force = true;
        engines = {
          "MyNixOS" = {
            urls = [ { template = "https://search.nüschtos.de/?query={searchTerms}"; } ];
            icon = "https://search.nüschtos.de/favicon.ico";
            definedAliases = [ "@nu" ];
          };
          "Noogle" = {
            urls = [ { template = "https://noogle.dev/q?term={searchTerms}"; } ];
            icon = "https://noogle.dev/favicon.png";
            definedAliases = [ "@noo" ];
          };
        };
      };

      userChrome = userChrome.css;
    };
  };

  stylix.targets.librewolf.profileNames = [ "${username}" ];
}
