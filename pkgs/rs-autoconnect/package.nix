{ lib
, multiStdenv
, fetchFromGitHub
, cmake
, pkgsi686Linux
,
}:
multiStdenv.mkDerivation (finalAttrs: {
  pname = "rs-autoconnect";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "KczBen";
    repo = "rs-linux-autoconnect";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Uk4J2ZGHZFI6RX7pmGbdgxUWWdOegsNtJLc/aeBnj54=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    pkgsi686Linux.jack2
  ];

  installPhase = ''
    mkdir -p $out/lib
    cp librsshim.so $out/lib
  '';

  meta = {
    description = "A shim library to automatically connect Rocksmith 2014 on Linux to hardware inputs and outputs";
    homepage = "https://github.com/quantumvoid0/sysinfo";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      rein
    ];
  };
})
