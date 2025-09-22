hdr: {
  "services.sync.engine.bookmarks" = true;
  "services.sync.engine.tabs" = true;
  "services.sync.engine.addons" = false;
  "services.sync.engine.addresses" = false;
  "services.sync.engine.addresses.available" = false;
  "services.sync.engine.creditcards" = false;
  "services.sync.engine.creditcards.available" = false;
  "services.sync.engine.history" = false;
  "services.sync.engine.passwords" = false;
  "services.sync.engine.prefs" = false;
  "identity.fxaccounts.enabled" = false;

  "accessibility.force_disabled" = 1;

  "app.normandy.first_run" = false;
  "app.normandy.api_url" = "";
  "app.normandy.enabled" = false;

  "app.shield.optoutstudies.enabled" = false;

  "app.update.channel" = "default";

  "browser.aboutConfig.showWarning" = false;

  "browser.display.use_document_fonts" = 0;

  # Make private window more consistent
  "browser.search.separatePrivateDefault" = false;
  "browser.theme.dark-private-windows" = false;

  "browser.discovery.enabled" = false;
  "browser.helperApps.deleteTempFileOnExit" = true;

  # Disable translations
  "browser.translations.enable" = false;
  "browser.translations.automaticallyPopup" = false;
  "browser.translations.select.enable" = false;

  "browser.urlbar.quickactions.enabled" = false;
  "browser.urlbar.quickactions.showPrefs" = false;
  "browser.urlbar.shortcuts.quickactions" = false;
  "browser.urlbar.suggest.quickactions" = false;

  "browser.toolbars.bookmarks.visibility" = "newtab";

  "dom.forms.autocomplete.formautofill" = false;

  # Automatically enable installed extensions
  "extensions.autoDisableScopes" = 0;

  # Disable automatic updates for extensions
  "extensions.update.enabled" = false;
  "extensions.update.autoUpdateDefault" = false;

  "extensions.webcompat.enable_picture_in_picture_overrides" = true;
  "extensions.webcompat.enable_shims" = true;
  "extensions.webcompat.perform_injections" = true;
  "extensions.webcompat.perform_ua_overrides" = true;

  # "gfx.wayland.hdr" = hdr;
  # "gfx.webrender.all" = true;

  "widget.dmabuf.force-enabled" = true;

  "media.ffmpeg.vaapi.enabled" = true;
  "media.gpu-process-decoder" = true;
  "media.rdd-ffmpeg.enabled" = true;

  "network.connectivity-service.enabled" = false;

  # Automatically clear history on shutdown
  # Do not clear cookies or local storage on shutdown
  "privacy.clearOnShutdown.cookies" = false;
  "privacy.clearOnShutdown.history" = true;
  "privacy.sanitize.sanitizeOnShutdown" = false;

  "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
  "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
  "privacy.clearOnShutdown_v2.cache" = false;

  # Enable userChrome.css
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

  # Enable WebGL
  "webgl.disabled" = false;

  # Use xdg utils for better integration with the rest of thingies
  "widget.use-xdg-desktop-portal.file-picker" = 1;
  "widget.use-xdg-desktop-portal.mime-handler" = 1;
  "widget.use-xdg-desktop-portal.settings" = 1;
  "widget.use-xdg-desktop-portal.open-uri" = 1;

  # Custom toolbar
  "browser.uiCustomization.state" = builtins.toJSON {
    placements = {
      nav-bar = [
        "back-button"
        "forward-button"
        "stop-reload-button"
        "vertical-spacer"
        "urlbar-container"
        "downloads-button"
        "fxa-toolbar-menu-button"
        "unified-extensions-button"
        "ff2mpv_yossarian_net-browser-action"
        "foxyproxy_eric_h_jung-browser-action"
        "_eec37db0-22ad-4bf1-9068-5ae08df8c7e9_-browser-action"
        "_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"
        "ublock0_raymondhill_net-browser-action"
      ];

      toolbar-menubar = [
        "menubar-items"
      ];

      TabsToolbar = [
        "tabbrowser-tabs"
        "new-tab-button"
        "alltabs-button"
      ];

      PersonalToolbar = [
        "personal-bookmarks"
      ];

      unified-extensions-area = [
        "7esoorv3_alefvanoon_anonaddy_me-browser-action"
        "_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"
        "_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action"
        "sponsorblocker_ajay_app-browser-action"
        "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
      ];

      widget-overflow-fixed-list = [ ];
    };

    seen = [
      "7esoorv3_alefvanoon_anonaddy_me-browser-action"
      "_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"
      "_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action"
      "sponsorblocker_ajay_app-browser-action"
      "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
      "ublock0_raymondhill_net-browser-action"
      "_eec37db0-22ad-4bf1-9068-5ae08df8c7e9_-browser-action"
      "ff2mpv_yossarian_net-browser-action"
      "foxyproxy_eric_h_jung-browser-action"
      "_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"
      "developer-button"
    ];

    dirtyAreaCache = [
      "nav-bar"
      "unified-extensions-area"
    ];

    currentVersion = 21;
    newElementCount = 4;
  };
}
