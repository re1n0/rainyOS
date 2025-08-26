{ config, ... }:
let
  cfg = config.rainyos;
in
{
  hardware = {
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
    bluetooth.enable = cfg.bluetooth.enable;
    bluetooth.powerOnBoot = cfg.bluetooth.enable;
  };

  time.hardwareClockInLocalTime = true;
}
