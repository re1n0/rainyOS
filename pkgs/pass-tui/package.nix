{
  lib,
  rustPlatform,
  fetchFromGitea,
  gpgme,
  libgpg-error,
  pkg-config,
  stdenv,
  wayland,
  nix-update-script,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "pass-tui";
  version = "0.1.1";
  __structuredAttrs = true;

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "frofor";
    repo = "pass-tui";
    tag = "v${finalAttrs.version}";
    hash = "sha256-4dFZT5fHXibWxYSMjtq4Z8zfSvQO/thtKWMzzOa/0OQ=";
  };

  cargoHash = "sha256-bLk+OlaIhXLmDhXMT6tnQnUEmyYZjb1WN47RWDWNTtE=";

  nativeBuildInputs = [
    gpgme
    libgpg-error
    pkg-config
  ];

  buildInputs =
    [
      gpgme
      libgpg-error
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      wayland
    ];

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "Unix-style TUI password manager implementing the Password Store standard";
    homepage = "https://codeberg.org/frofor/pass-tui";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [rein];
    mainProgram = "pass-tui";
  };
})
