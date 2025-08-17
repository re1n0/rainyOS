{ lib, config, ... }:
lib.mkIf config.rainyos.virtualisation.podman.enable {
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
