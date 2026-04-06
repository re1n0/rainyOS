{ pkgs, ... }:
{
  hardware.amdgpu = {
    overdrive = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };

    initrd.enable = true;
  };

  mesa-git = {
    enable = true;
    drivers = [ "amd" ];
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
}
