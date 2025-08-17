{ lib, config, ... }:
lib.mkIf config.drivers.amd.enable {
  hardware.cpu.amd.updateMicrocode = true;
}
