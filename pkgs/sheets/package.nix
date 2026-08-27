{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:
buildGoModule (finalAttrs: {
  pname = "sheets";
  version = "0.2.0";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "maaslalani";
    repo = "sheets";
    tag = "v${finalAttrs.version}";
    hash = "sha256-xDu+jbWH7ubXC6ImvkRVgPI0OHAaUQ60sELDJN8hY1M=";
  };

  vendorHash = "sha256-X7bfALH9mM15HP6SM60CFIG1rm4Ma6LEh2p7z5LNW64=";

  ldflags = ["-s"];

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "Terminal based spreadsheet tool";
    homepage = "https://github.com/maaslalani/sheets";
    changelog = "https://github.com/maaslalani/sheets/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [rein];
    mainProgram = "sheets";
  };
})
