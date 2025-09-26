{
  lib,
  zig_0_14,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  pixman,
  lz4,
  ffmpeg,
  stb,
  wayland-protocols,
  wayland-scanner,
  callPackage,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "yin";
  version = "2025-09-08";

  src = fetchFromGitHub {
    owner = "SaverinOnRails";
    repo = "yin";
    rev = "c643696699380549f3bdc11dcc573cc9f73bd21a";
    hash = "sha256-G91kaQuJ7t3isKmpLGtyWYaMsNC2XJAEDCRHXVcgXwI=";
  };

  deps = callPackage ./deps.nix {
    name = "${finalAttrs.pname}-cache-${finalAttrs.version}";
    zig = zig_0_14;
  };

  nativeBuildInputs = [
    pkg-config
    wayland-protocols
    wayland-scanner
    zig_0_14.hook
  ];

  buildInputs = [
    pixman
    lz4
    ffmpeg
    stb
  ];

  dontConfigure = true;

  zigBuildFlags = [
    "--system"
    "${finalAttrs.deps}"
  ];

  zigCheckFlags = finalAttrs.zigBuildFlags;

  doCheck = true;

  meta = {
    description = "Animated wallpaper daemon";
    homepage = "https://github.com/SaverinOnRails/yin";
    maintainers = with lib.maintainers; [
      rein
    ];
    mainProgram = "yinctl";
  };
})
