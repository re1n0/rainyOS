{ lib, pkgs, ... }:
let
  inherit (lib.gvariant) mkDictionaryEntry mkVariant;
in
{
  home.packages = with pkgs; [
    epiphany
  ];

  dconf.settings = {
    "org/gnome/epiphany" = {
      "ask-for-default" = false;

      "web/enable-adblock" = true;
      "web/ask-on-download" = true;
      "web/remember-passwords" = false;

      homepage-url = "about:newtab";
      start-in-incognito-mode = false;
      restore-session-policy = "always";
      use-google-search-suggestions = false;

      search-engine-providers = [
        (mkDictionaryEntry "url" (mkVariant "https://duckduckgo.com/?q=%s"))
        (mkDictionaryEntry "bang" (mkVariant "!d"))
        (mkDictionaryEntry "name" (mkVariant "DuckDuckGo"))
      ];
    };
  };
}
