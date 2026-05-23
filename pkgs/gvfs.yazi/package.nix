{
  lib,
  stdenvNoCC,
  rainySources,
}:
stdenvNoCC.mkDerivation {
  inherit (rainySources."gvfs.yazi")
    pname
    version
    src
    date
    ;

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
