{ pkgs, ... }:
{
  hardware.amdgpu = {
    amdvlk = {
      enable = true;
      support32Bit.enable = true;
      supportExperimental.enable = true;
    };

    overdrive = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };

    initrd.enable = true;
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  chaotic.hdr.enable = true;
}
