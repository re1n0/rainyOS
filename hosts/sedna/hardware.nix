{ pkgs, ... }:
{
  hardware.amdgpu = {
    overdrive = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };

    initrd.enable = true;
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
}
