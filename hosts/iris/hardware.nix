{ config, pkgs, ... }:
{
  hardware.nvidia = {
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    modesetting.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
  };

  boot.blacklistedKernelModules = [ "nouveau" ];
}
