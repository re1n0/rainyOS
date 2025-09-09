{ lib, os, ... }:
lib.optionalAttrs os.gui.enable {
  imports = [
    ./hyprland
    ./swww.nix
    # ./yin.nix
  ];
}
