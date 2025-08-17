{ lib, config, ... }:
lib.mkIf config.drivers.intel.enable {
  hardware.cpu.intel.updateMicrocode = true;
}
