{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.rainyos;
in
{
  environment.systemPackages = with pkgs; [
    sbctl
  ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos;

    plymouth.enable = cfg.gui.enable;
    consoleLogLevel = 3;
    initrd.verbose = false;

    initrd.systemd.enable = true;

    kernelParams = [
      "quiet"
      "splash"
      "intremap=on"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    lanzaboote = lib.mkIf cfg.secureBoot.enable {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  boot.loader =
    if cfg.secureBoot.enable then
      {
        systemd-boot.enable = lib.mkForce false;
      }
    else
      {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        timeout = 3;
      };
}
