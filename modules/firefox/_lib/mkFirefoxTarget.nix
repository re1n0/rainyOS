{mkTarget}: name: description:
mkTarget name {
  tags = ["gui" name];
  inherit description;

  hm = {
    config,
    pkgs,
    ...
  }: let
    inherit (config.home) username;
  in {
    programs.${name} = {
      enable = true;

      nativeMessagingHosts = with pkgs; [
        ff2mpv-rust
        gopass-jsonapi
      ];

      profiles.${username} = {
        id = 0;
        name = username;
        isDefault = true;
      };

      profiles.${username}.search = {
        force = true;
        default = "sp";
        engines = {
          "NüschtOS Search (Options)" = {
            urls = [{template = "https://search.nüschtos.de/options?query={searchTerms}";}];
            icon = "https://search.nüschtos.de/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@no"];
          };
          "NüschtOS Search (Packages)" = {
            urls = [{template = "https://search.nüschtos.de/packages?query={searchTerms}";}];
            icon = "https://search.nüschtos.de/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@np"];
          };
          "Noogle" = {
            urls = [{template = "https://noogle.dev/q?term={searchTerms}";}];
            icon = "https://noogle.dev/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@noo"];
          };
          "NixOS Wiki" = {
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
            iconUpdateURL = "https://wiki.nixos.org/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@nw"];
          };
          bing.metaData.hidden = true;
          google.metaData.hidden = true;
          ddg.metaData.hidden = true;
        };
      };

      profiles.${username}.extensions.packages = with pkgs.firefoxAddons; [
        # keep-sorted start block=yes
        (canvasblocker.override {private_browsing = true;})
        (clearurls.override {private_browsing = true;})
        (foxyproxy-standard.override {private_browsing = true;})
        (localcdn.override {private_browsing = true;})
        (ublock-origin.override {private_browsing = true;})
        (user-agent-string-switcher.override {private_browsing = true;})
        consent-o-matic
        fastforwardteam
        ff2mpv
        github-file-icons
        gopass-bridge
        unpaywall
        web-archives
        # keep-sorted end
      ];

      profiles.${username}.extensions.force = true;

      profiles.${username}.extensions.settings = {
        "uBlock0@raymondhill.net".settings = {
          selectedFilterLists = [
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "easylist"
            "easyprivacy"
            "LegitimateURLShortener"
            "adguard-spyware-url"
            "urlhaus-1"
            "curben-phishing"
            "plowe-0"
            "ublock-annoyances"
            "DEU-0"
            "RUS-0"
            "POL-0"
            "CZE-0"
            "ROU-1"
          ];
        };

        "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
          settings = {
            ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/154.0";
          };

          permissions = [
            "storage"
            "contextMenus"
            "scripting"
            "webRequest"
            "declarativeNetRequestWithHostAccess"
          ];
        };
      };
    };
  };
}
