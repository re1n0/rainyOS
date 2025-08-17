{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    handlr-regex
    (writeShellApplication {
      name = "xdg-open";
      runtimeInputs = [ handlr-regex ];
      text = # shell
        ''
          handlr open -- "$@"
        '';
    })
    (writeShellApplication {
      name = "xterm";
      runtimeInputs = [ handlr-regex ];
      text = # shell
        ''
          handlr launch x-scheme-handler/terminal -- "$@"
        '';
    })
  ];

  xdg.configFile."handlr/handlr.toml".source =
    (inputs.nixago.lib.${pkgs.system}.make {
      data = {
        enable_selector = false;
        handlers = [
          {
            exec = "freetube %u";
            regexes = [ "youtu(be.com|.be)" ];
          }
          {
            exec = "handlr open steam://openurl/%u";
            regexes = [ "^https://([[:alpha:]]*\.)?steam(powered|community).com/" ];
          }
        ];
      };
      output = "handlr.toml";
    }).configFile;
}
