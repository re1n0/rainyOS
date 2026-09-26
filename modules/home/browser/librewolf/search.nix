{
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
}
