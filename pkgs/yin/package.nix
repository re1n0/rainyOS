{ lib
, zig_0_13
, stdenv
, fetchFromGitHub
, pkg-config
, pixman
, versionCheckHook
, writableTmpDirAsHomeHook
, nix-update-script
, lz4
, ffmpeg
, callPackage
,
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

  nativeBuildInputs = [
    pkg-config
    zig_0_13.hook
    writableTmpDirAsHomeHook
  ];

  buildInputs = [
    pixman
    lz4
    ffmpeg
  ];

  nativeInstallCheckInputs = [
    versionCheckHook
  ];

  doInstallCheck = true;

  passthru.updateScript = nix-update-script { };

  deps = callPackage ./deps.nix {
    name = "${finalAttrs.pname}-cache-${finalAttrs.version}";
    zig = zig_0_13;
  };

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
