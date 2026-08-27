{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:
buildGoModule (_finalAttrs: {
  pname = "gosheet";
  version = "0-unstable-2026-11-05";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "drclcomputers";
    repo = "GoSheet";
    rev = "ec3a16419c7b43497829187d2d1dd44ed56fb474";
    hash = "sha256-nHp/ltRZiU3Vapk9NnP+3yJ//+XUnTm4TUDN7xRhmh8=";
  };

  vendorHash = "sha256-JZof/jOEBr/FSJLIq4+A1FOkeiRf83Q6TCu+02y/cfY=";

  ldflags = ["-s"];

  passthru.updateScript = nix-update-script {
    extraArgs = ["--flake"];
  };

  meta = {
    description = "A powerful CLI spreadsheet editor";
    homepage = "https://github.com/drclcomputers/GoSheet";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [rein];
    mainProgram = "gosheet";
  };
})
