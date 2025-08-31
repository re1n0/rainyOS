{
  lib,
  writeShellApplication,
  bash,
  coreutils,
  findutils,
  gawk,
  gnutar,
  unzip,
  wget,
  steam-run,
  fetchFromGitHub,
}:
writeShellApplication {
  name = "patch-rocksmith";

  runtimeInputs = [
    bash
    coreutils
    findutils
    gawk
    gnutar
    unzip
    wget
    steam-run
  ];

  text =
    fetchFromGitHub {
      owner = "theNizo";
      repo = "linux_rocksmith";
      rev = "6914aa88aa836a7b0abfeeb36ffec4167eb7aa95";
      hash = "sha256-XJ5hYe7Gob5VsnUYW3Gq/OgHykBYnfjsqJajFKbrcgs=";
    }
    + "/scripts/patch-nixos.sh";

  meta = {
    description = "Script to patch Rocksmith 2014";
    homepage = "https://github.com/theNizo/linux_rocksmith";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [
      rein
    ];
    mainProgram = "patch-rocksmith";
  };
}
