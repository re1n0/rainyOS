{ lib, ... }:
with lib;
{
  options.drivers.amd.enable = mkEnableOption "Enable AMD CPU drivers";

  options.drivers.intel.enable = mkEnableOption "Enable Intel CPU drivers";

  options.drivers.amdGpu = {
    enable = mkEnableOption "Enable AMD GPU Drivers";
    hdr = mkEnableOption "(EXPERIMENTAL) Enable AMD-HDR";
  };

  options.drivers.nvidia = {
    enable = mkEnableOption "Enable NVIDIA drivers";
    enable32bit = mkEnableOption "Enable 32bit NVIDIA driver package";
    open = mkOption {
      type = types.bool;
      default = true;
      description = "Use the NVIDIA open kernel module. Turing or newer only";
    };
    powerManagement = mkEnableOption "Use the NVIDIA power management. Might cause sleep/suspend issues";
    containerToolkit = mkEnableOption "Runs nvidia-container-toolkit on boot for dynamic CDI configuration";
  };

  options.local.hardwareClock = {
    enable = mkEnableOption "Change the hardware clock to local time";
  };

  options.vm.guestServices = {
    enable = mkEnableOption "Enable Virtual Machine Guest services";
  };

  imports = [
    ./amd-drivers.nix
    ./intel-drivers.nix

    ./amdgpu-drivers.nix
    ./nvidia-drivers.nix

    ./local-hardware-clock.nix

    ./vm-guest-services.nix
  ];
}
