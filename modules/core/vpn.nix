{ lib, config, ... }:
lib.mkIf config.rainyos.vpn.amneziawg.enable {
  boot.extraModulePackages = [ config.boot.kernelPackages.amneziawg ];
  boot.kernelModules = [ "amneziawg" ];
  programs.amnezia-vpn.enable = true;
}
