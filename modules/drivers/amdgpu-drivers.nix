{
  lib,
  config,
  ...
}:
let
  cfg = config.drivers.amdGpu;
in
lib.mkIf cfg.enable {
  hardware.amdgpu = {
    amdvlk = {
      enable = true;
      supportExperimental.enable = true;
      support32Bit.enable = true;
    };

    overdrive = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };

    opencl.enable = true;

    initrd.enable = true;
  };

  chaotic.hdr.enable = cfg.hdr;
}
