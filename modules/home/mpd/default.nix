{ lib, os, ... }:
lib.optionalAttrs os.mpd.enable {
  imports = [
    ./mpd.nix
    ./rmpc.nix
  ];
}
