{
  pkgs,
  lib,
  os,
  ...
}:
lib.optionalAttrs os.gui.enable {
  home.packages = with pkgs; [
    lingot
    crosspipe
    android-tools
  ];
}
