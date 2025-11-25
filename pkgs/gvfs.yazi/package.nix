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
    rev = "d4b8d83d37fcb10a53e1ca07f8ee011dff089c91";
    hash = "sha256-6VNra6WUjDfBdGjCw/6VOAaAgZLF78/4Gj47BOh1Q/0=";
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
