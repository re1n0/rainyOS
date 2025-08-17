{ lib, config, ... }:
lib.mkIf config.vm.guestServices.enable {
  virtualisation.vmware.guest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;
}
