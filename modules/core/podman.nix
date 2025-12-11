{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.rainyos.virtualisation.podman.enable {
  virtualisation.containers.enable = true;

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.etc."containers/registries.conf" = {
    text = lib.mkForce ''
      credential-helpers = ["pass"]

      unqualified-search-registries = ["docker.io", "quay.io"]

      insecure-registries = []

      blocked-registries = []
    '';
    mode = "0644";
  };

  environment.systemPackages = with pkgs; [
    docker-credential-helpers
  ];
}
