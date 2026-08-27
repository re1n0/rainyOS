{
  os,
  lib,
  ...
}:
lib.optionalAttrs os.bluetooth.enable {
  services.mpris-proxy.enable = true;
}
