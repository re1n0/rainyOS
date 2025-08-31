{
  force = true;
  engines = {
    "NüschtOS Search" = {
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
}
