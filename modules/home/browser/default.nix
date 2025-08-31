{ lib, os, ... }:
lib.optionalAttrs os.gui.enable {
  imports = [
    ./chromium
    ./librewolf
  ];
}
