{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, # versionCheckHook,
  # nix-update-script,
  gcc
, ncurses
,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "sysinfo";
  version = "1.8";

  src = fetchFromGitHub {
    owner = "quantumvoid0";
    repo = "sysinfo";
    tag = "v${finalAttrs.version}";
    hash = "sha256-IgeXY1EGFQmlXPlk/0iy/2U5RoiI9VvPZ/8JXCsIk0I=";
  };

  nativeBuildInputs = [
    pkg-config
    gcc
  ];

  buildInputs = [
    ncurses
  ];

  /*
    nativeInstallCheckInputs = [
      versionCheckHook
    ];

    doInstallCheck = true;

    passthru.updateScript = nix-update-script { };
  */

  buildPhase = ''
    echo "Compiling binaries..."
    gcc src/main.c src/swap.c src/cpu.c src/ram.c src/sys.c src/time.c src/date.c -o sys
    gcc src/live.c -o live -lncurses -ltinfo
    gcc src/fetch.c -o fetch
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp sys $out/bin/
    cp live $out/bin/
    cp fetch $out/bin/

    mkdir -p $out/share/sysinfo/art
    cp -r src/art/ $out/share/sysinfo/art/
  '';

  meta = {
    description = "System information and monitor in ncurses";
    homepage = "https://github.com/quantumvoid0/sysinfo";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [
      rein
    ];
    mainProgram = "sys";
  };
})
