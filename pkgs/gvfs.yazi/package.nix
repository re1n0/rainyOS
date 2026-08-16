{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "gvfs.yazi";
  version = "0-unstable-2026-08-09";

  src = fetchFromGitHub {
    owner = "boydaihungst";
    repo = "gvfs.yazi";
    rev = "ebdb87c9783d302a0129911c31c0ae3eb27a5c9f";
    hash = "sha256-0vW2LBv0r3N91wy5ajra8b0jPeLJ89iE0kP/meTVc7U=";
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
    maintainers = with lib.maintainers; [rein];
  };
}
