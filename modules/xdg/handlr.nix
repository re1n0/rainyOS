{mkTarget, ...}:
mkTarget "handlr" {
  tags = ["xdg"];
  description = "Better xdg-open";

  nixos = {
    pkgs,
    lib,
    ...
  }: {
    system.replaceDependencies.replacements = [
      {
        oldDependency = pkgs.xdg-utils;
        replacement = pkgs.xdg-utils.overrideAttrs (old: let
          handlr-open = pkgs.writeShellScriptBin "xdg-open" ''
            exec ${lib.getExe pkgs.handlr-regex} open -- "$@"
          '';
        in {
          postFixup =
            (old.postFixup or "")
            + ''
              cp ${handlr-open}/bin/xdg-open $out/bin/xdg-open
            '';
        });
      }

      {
        oldDependency = pkgs.xterm;
        replacement =
          pkgs.symlinkJoin
          {
            name = "xterm-${pkgs.xterm.version}";
            paths = let
              handlr-xterm =
                pkgs.writeShellApplication
                {
                  name = "xterm";
                  runtimeInputs = [pkgs.handlr-regex];
                  text = ''
                    exec handlr launch x-scheme-handler/terminal -- "$@"
                  '';
                };
            in [
              handlr-xterm
            ];
            postBuild = ''
              ln -sf $out/bin/xterm $out/bin/uxterm
              ln -sf $out/bin/xterm $out/bin/koi8rxterm
            '';
          };
      }
    ];
  };

  hm = {
    lib,
    pkgs,
    ...
  }: {
    programs.handlr-regex = {
      enable = true;
      config = {
        enable_selector = false;
        handlers = [
          {
            exec = "mpv %u";
            regexes = ["youtu(be.com|be)"];
          }
          {
            exec = "${lib.getExe pkgs.handlr-regex} open steam://openurl/%u";
            regexes = ["^https://([[:alpha:]]*\.)?steam(powered|community).com/"];
          }
        ];
      };
    };
  };
}
