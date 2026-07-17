{
  lib,
  stdenvNoCC,
  pins,
}:
let
  gvfs-yazi = pins."gvfs.yazi";
in
stdenvNoCC.mkDerivation {
  pname = "gvfs.yazi";
  version = "0-git+${gvfs-yazi.revision}";

  src = gvfs-yazi;

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
