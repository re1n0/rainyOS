{
  writeShellApplication,
  git,
  jq,
  nix,
  nixos-install-tools,
  disko,
}:
writeShellApplication {
  name = "rainy-install";

  runtimeInputs = [
    git
    jq
    nix
    nixos-install-tools
    disko
  ];

  text = builtins.readFile ./install.sh;
}
