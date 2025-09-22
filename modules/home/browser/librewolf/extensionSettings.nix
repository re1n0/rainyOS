{
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

  "foxyproxy@eric.h.jung" = {
    settings = {
      mode = "disable";
      sync = false;
      autoBackup = false;
      container = {
        incognito = "192.168.88.2:4444";
      };
      commands = {
        setProxy = "";
        setTabProxy = "";
        includeHost = "";
        excludeHost = "";
      };
      data = [
        {
          active = true;
          title = "I2P";
          type = "http";
          hostname = "192.168.88.2";
          port = "4444";
          username = "";
          password = "";
          color = "#e5a50a";
          proxyDNS = true;
          include = [ ];
          exclude = [ ];
          tabProxy = [ ];
        }
      ];
    };
  };

  "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
    settings = {
      ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:140.0) Gecko/20100101 Firefox/140.0";
    };

    permissions = [
      "storage"
      "contextMenus"
      "scripting"
      "declarativeNetRequestWithHostAccess"
    ];
  };
}
