{mkTarget, ...}:
mkTarget "networkmanager" {
  tags = ["networkmanager"];
  description = "NetworkManager with additional utilities";

  nixos = {
    config,
    options,
    pkgs,
    ...
  }: {
    networking = {
      networkmanager.enable = true;
      timeServers = ["ntp.ripe.net" "europe.pool.ntp.org" "pool.ntp.org"] ++ options.networking.timeServers.default;
    };

    environment.systemPackages = [pkgs.wifitui];

    persist.directories = ["/etc/NetworkManager/system-connections"];

    users.users.${config.rainy.settings.username}.extraGroups = ["networkmanager"];
  };
}
