{
  pkgs,
  lib,
  os,
  ...
}:
lib.optionalAttrs os.gui.enable {
  home.packages = with pkgs; [gimp-with-plugins];
  xdg.configFile."GIMP/3.2/gimprc".text =
    # scheme
    ''
      (theme "System")
    '';
}
