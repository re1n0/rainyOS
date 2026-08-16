{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  rust-jemalloc-sys,
  zstd,
  nix-update-script,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "oc-rsync";
  version = "0.6.4";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "oferchen";
    repo = "rsync";
    tag = "v${finalAttrs.version}";
    hash = "sha256-x9oozKIFgnyPT2gYjb39gW0GAu7VMdS3NbrL56i92xs=";
  };

  cargoHash = "sha256-ZmBUpJObibj7fcskQPrForwI5bGb4CaZg2svz1whxUw=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
    rust-jemalloc-sys
    zstd
  ];

  env = {
    OPENSSL_NO_VENDOR = true;
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "Classic rsync re-implementation in pure Rust";
    homepage = "https://github.com/oferchen/rsync";
    changelog = "https://github.com/oferchen/rsync/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [rein];
    mainProgram = "oc-rsync";
  };
})
