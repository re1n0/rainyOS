{
  lib,
  host,
  options,
  config,
  ...
}:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

    wireguard.enable = true;
  };

  networking.firewall = {
    enable = true;

    trustedInterfaces = lib.optional config.rainyos.virtualisation.virt-manager.enable "virbr0";
  };

  systemd.network.wait-online.enable = lib.mkForce false;
  networking.useNetworkd = lib.mkForce false;
}
