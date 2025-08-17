{ lib, os, ... }:
lib.optionalAttrs os.gui.enable {
  programs.imv.enable = true;
}
