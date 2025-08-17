{ lib, os, ... }:
lib.optionalAttrs os.audio.enable {
  services.easyeffects.enable = true;
}
