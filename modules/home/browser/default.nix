{ lib, os, ... }:
lib.optionalAttrs os.gui.enable {
  imports = [
    # ./browserpass.nix
    ./librewolf.nix
  ];
}
