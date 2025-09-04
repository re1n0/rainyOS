{
  lib,
  stdenv,
  perl,
  which,
  coreutils,
  zenity,
  curl,
  cabextract,
  unzip,
  p7zip,
  gnused,
  gnugrep,
  bash,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "winetricks";
  version = "20250902";

  src = fetchFromGitHub {
    hash = "sha256-vIUbDZINaBnsSCdQEba6Ym34p/Ww3ApHG/i4Xe34Uck=";
    owner = "Winetricks";
    repo = "winetricks";
    rev = "75118236ac5cb6f51918460a14f7bc40162a115e";
  };

  buildInputs = [
    perl
    which
  ];

  pathAdd = lib.makeBinPath [
    perl
    which
    coreutils
    zenity
    curl
    cabextract
    unzip
    p7zip
    gnused
    gnugrep
    bash
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  doCheck = false;

  postInstall = ''
    sed -i \
      -e '2i PATH="${pathAdd}:$PATH"' \
      "$out/bin/winetricks"
  '';

  passthru = {
    inherit (src) updateScript;
  };

  meta = {
    description = "Script to install DLLs needed to work around problems in Wine";
    mainProgram = "winetricks";
    license = lib.licenses.lgpl21;
    homepage = "https://github.com/Winetricks/winetricks";
    platforms = with lib.platforms; linux ++ darwin;
  };
}
