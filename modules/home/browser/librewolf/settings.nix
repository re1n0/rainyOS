hdr: {
  "accessibility.force_disabled" = 1;

  "app.normandy.first_run" = false;
  "app.normandy.api_url" = "";
  "app.normandy.enabled" = false;

  "app.shield.optoutstudies.enabled" = false;

  "app.update.channel" = "default";

  "browser.aboutConfig.showWarning" = false;

  "browser.display.use_document_fonts" = 0;

  "browser.search.separatePrivateDefault" = false;
  "browser.theme.dark-private-windows" = false;

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
  "extensions.update.autoUpdateDefault" = false;
  "extensions.webcompat.enable_picture_in_picture_overrides" = true;
  "extensions.webcompat.enable_shims" = true;
  "extensions.webcompat.perform_injections" = true;
  "extensions.webcompat.perform_ua_overrides" = true;
  "extensions.autoDisableScopes" = 0;

  "gfx.wayland.hdr" = hdr;

  "gfx.webrender.all" = true;

  "media.ffmpeg.vaapi.enabled" = true;
  "media.ffvpx.enabled" = false;
  "media.ffvpx-hw.enabled" = false;
  "media.rdd-vpx.enabled" = false;
  "media.navigator.mediadatadecoder_vpx_enabled" = true;

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

  "browser.uiCustomization.state" = builtins.toJSON {
    Value = {
      placements = {
        widget-overflow-fixed-list = [ ];

        unified-extensions-area = [
          "7esoorv3_alefvanoon_anonaddy_me-browser-action"
          "_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"
          "_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action"
          "sponsorblocker_ajay_app-browser-action"
          "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
          "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
        ];

        nav-bar = [
          "back-button"
          "forward-button"
          "stop-reload-button"
          "sidebar-button"
          "customizableui-special-spring1"
          "vertical-spacer"
          "urlbar-container"
          "customizableui-special-spring2"
          "downloads-button"
          "fxa-toolbar-menu-button"
          "ublock0_raymondhill_net-browser-action"
          "_eec37db0-22ad-4bf1-9068-5ae08df8c7e9_-browser-action"
          "ff2mpv_yossarian_net-browser-action"
          "foxyproxy_eric_h_jung-browser-action"
          "_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"
          "unified-extensions-button"
        ];

        toolbar-menubar = [
          "menubar-items"
        ];

        TabsToolbar = [
          "firefox-view-button"
          "tabbrowser-tabs"
          "new-tab-button"
          "alltabs-button"
        ];
        vertical-tabs = [ ];

        PersonalToolbar = [
          "personal-bookmarks"
        ];
      };

      seen = [
        "7esoorv3_alefvanoon_anonaddy_me-browser-action"
        "_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"
        "_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action"
        "sponsorblocker_ajay_app-browser-action"
        "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
        "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
        "ublock0_raymondhill_net-browser-action"
        "_eec37db0-22ad-4bf1-9068-5ae08df8c7e9_-browser-action"
        "ff2mpv_yossarian_net-browser-action"
        "foxyproxy_eric_h_jung-browser-action"
        "_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"
        "developer-button"
      ];

      dirtyAreaCache = [
        "unified-extensions-area"
        "nav-bar"
        "vertical-tabs"
      ];

      currentVersion = 21;
      newElementCount = 4;
    };

    Status = "locked";
  };
}
