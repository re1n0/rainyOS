{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.rainyos.virtualisation.virt-manager.enable {
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  programs.virt-manager.enable = true;
}
