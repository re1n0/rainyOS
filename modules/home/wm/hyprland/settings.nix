{
  lib,
  os,
  pkgs,
}:

let
  toLua = lib.generators.toLua { };

  monitorData = map (m: {
    inherit (m)
      connector
      width
      height
      refresh
      position
      scale
      wide_color
      hdr
      icc
      ;
  }) os.gui.monitors;

in
pkgs.writeText "hyprland-nix-vars.lua" ''
  NIX_KB_LAYOUT = ${toLua (builtins.concatStringsSep "," os.keymap.supported)}

  NIX_MONITORS = ${toLua monitorData}
''
