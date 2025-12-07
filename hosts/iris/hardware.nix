{ config, pkgs, ... }:
{
  hardware.nvidia = {
    open = true;

    modesetting.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  hardware.graphics = {
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      egl-wayland
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      nvidia-vaapi-driver
      egl-wayland
    ];
  };
}
