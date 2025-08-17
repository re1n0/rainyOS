{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.drivers.amdGpu;
in
lib.mkIf cfg.enable {
  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  chaotic.hdr.enable = cfg.hdr;
}
