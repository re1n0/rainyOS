{ lib
, stdenv
,
}:
stdenv.mkDerivation rec {
  name = "themes";

  src = ./.;

  installPhase = ''
    mkdir -p $out
    cp -r ${src}/res/* $out
  '';

  meta = {
    description = "Themes in base24 format";
    maintainers = with lib.maintainers; [
      rein
    ];
  };
}
