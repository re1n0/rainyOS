{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.rainyos;
in
  lib.mkIf (config.rainyos.configuration == "desktop") {
    environment.systemPackages = with pkgs; [
      sbctl
    ];

    boot = {
      kernelPackages = lib.mkDefault pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;

      plymouth.enable = cfg.gui.enable;
      consoleLogLevel = 3;
      initrd.verbose = false;

      initrd.systemd.enable = true;

      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
        "transparent_hugepage=madvise"
      ];

      kernelModules = [
        "ntsync"
      ];

      supportedFilesystems = ["ntfs"];
    };

    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.loader.limine = {
      enable = true;
      secureBoot.enable = cfg.secureBoot.enable;
      secureBoot.autoEnrollKeys.enable = cfg.secureBoot.enable;
    };
  }
