{ config, lib, ... }:
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
}
