{ config, ... }:
{
  hardware.nvidia = {
    open = true;

    modesetting.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.package =
    let
      base = config.boot.kernelPackages.nvidiaPackages.beta;
    in
    base;

  mesa-git = {
    enable = true;
    drivers = [ "nvidia" ];
  };
}
