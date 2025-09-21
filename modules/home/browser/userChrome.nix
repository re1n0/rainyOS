pkgs:
let
  compileScss = pkgs.stdenv.mkDerivation {
    name = "compiled-css";
    src = ./styles;

    buildCommand = ''
      touch $out
      ${pkgs.grass-sass}/bin/grass $src/browser.scss $out
    '';
  };

  css = builtins.readFile compileScss;
in
{
  inherit css;
}
