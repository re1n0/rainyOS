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
  gawk,
  gnutar,
  gzip,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "winetricks";
  version = "20251104";

  src = fetchFromGitHub {
    hash = "sha256-Bt5wo7zEAN9Mh9dwbGPsSW8pt1ruBrn0Br9BdprtIRY=";
    owner = "Winetricks";
    repo = "winetricks";
    rev = "533f41704766765cfb3706fb2aa197acbb05df32";
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
    gawk
    gnutar
    gzip
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  doCheck = false; # requires "bashate"

  postInstall = ''
    sed -i \
      -e '2i PATH="${pathAdd}:$PATH"' \
      "$out/bin/winetricks"
  '';

  meta = {
    description = "Script to install DLLs needed to work around problems in Wine";
    mainProgram = "winetricks";
    license = lib.licenses.lgpl21;
    homepage = "https://github.com/Winetricks/winetricks";
    platforms = with lib.platforms; linux ++ darwin;
  };
}
