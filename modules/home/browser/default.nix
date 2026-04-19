{ lib, os, ... }:
lib.optionalAttrs os.gui.enable {
  imports = [
    ./librewolf
  ];
}
