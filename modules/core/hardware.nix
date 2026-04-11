{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.rainyos;
in
{
  hardware = {
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
  };

  hardware.bluetooth = lib.mkIf cfg.bluetooth.enable {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
        FastConnectable = true;
      };
    };
  };

  time.hardwareClockInLocalTime = true;

  hardware.graphics = lib.mkIf cfg.gui.enable {
    enable = true;
    enable32Bit = true;

    extraPackages =
      with pkgs;
      [
        libva-vdpau-driver
        libvdpau-va-gl
      ]
      ++ (lib.optional config.hardware.nvidia.enabled nvidia-vaapi-driver);

    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
}
