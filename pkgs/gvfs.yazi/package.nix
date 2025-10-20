{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "gvfs.yazi";
  version = "0-unstable-2025-10-21";

  src = fetchFromGitHub {
    owner = "boydaihungst";
    repo = "gvfs.yazi";
    rev = "63b2bec50ac93242faff94eed5a6b01d8bd1d5f8";
    hash = "sha256-c0e3MV3xlBJOwZS1wXy8H696gA/gUAwcfwLm7I38RuY=";
  };

  installPhase = ''
    runHook preInstall

    cp -r . $out

    runHook postInstall
  '';

  meta = {
    description = "Virtual Filesystem support in yazi";
    homepage = "https://github.com/boydaihungst/gvfs.yazi";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ rein ];
  };
}
