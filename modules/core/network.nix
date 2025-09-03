{ lib
, host
, options
, ...
}:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

    firewall.enable = true;

    wireguard.enable = true;
  };

  systemd.network.wait-online.enable = lib.mkForce false;
  networking.useNetworkd = lib.mkForce false;
}
