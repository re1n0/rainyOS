{ lib, config, ... }:
lib.mkIf config.local.hardwareClock.enable {
  time.hardwareClockInLocalTime = true;
}
