{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    handlr-regex
    xterm
  ];

  xdg.configFile."handlr/handlr.toml".source =
    (inputs.nixago.lib.${pkgs.system}.make {
      data = {
        enable_selector = false;
        handlers = [
          {
            exec = "mpv %u";
            regexes = ["youtu(be.com|.be)"];
          }
          {
            exec = "handlr open steam://openurl/%u";
            regexes = ["^https://([[:alpha:]]*\.)?steam(powered|community).com/"];
          }
        ];
      };
      output = "handlr.toml";
    }).configFile;
}
