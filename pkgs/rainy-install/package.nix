{ lib
, writeShellApplication
, git
, jq
, nix
, nixos-install-tools
, disko
, nixos-facter
, coreutils
, curl
,
}:
writeShellApplication {
  name = "rainy-install";

  runtimeInputs = [
    git
    jq
    nix
    nixos-install-tools
    disko
    nixos-facter
    coreutils
    curl
  ];

  text = builtins.readFile ./install.sh;

  meta = {
    description = "Partitions drives, generates facter report and installs NixOS";
    maintainers = with lib.maintainers; [
      rein
    ];
    mainProgram = "rainy-install";
  };
}
