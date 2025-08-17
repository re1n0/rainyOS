{ lib, config, ... }:
let
  cfg = config.drivers.nvidia;
in
lib.mkIf cfg.enable {
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = cfg.enable32bit;
    };

    nvidia = {
      modesetting.enable = true;

      powerManagement = {
        enable = cfg.powerManagement;
        finegrained = cfg.powerManagement;
      };

      inherit (cfg) open;
      nvidiaSettings = false;
    };

    nvidia-container-toolkit.enable = cfg.containerToolkit;
  };
}
