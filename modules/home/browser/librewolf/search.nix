{
  force = true;
  default = "ddg";
  engines = {

    "NüschtOS Search" = {
      urls = [ { template = "https://search.nüschtos.de/?query={searchTerms}"; } ];
      icon = "https://search.nüschtos.de/favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000;
      definedAliases = [ "@nu" ];
    };
    "Noogle" = {
      urls = [ { template = "https://noogle.dev/q?term={searchTerms}"; } ];
      icon = "https://noogle.dev/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000;
      definedAliases = [ "@noo" ];
    };
    "Nix Packages" = {
      urls = [ { template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; } ];
      icon = "https://search.nixos.org/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000;
      definedAliases = [ "@np" ];
    };
    bing.metaData.hidden = true;
    google.metaData.hidden = true;
    wikipedia.metaData.alias = "@w";
  };
}
