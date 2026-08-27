{mkTarget, ...}:
mkTarget "wireguard" {
  tags = ["networkmanager"];
  description = "WireGuard client configuration";

  nixos = _: {
    networking.wireguard = {
      enable = true;
    };

    firewall.reversePathFilterRules = [
      ''
        udp sport 51820 accept
        udp dport 51820 accept
      ''
    ];
  };
}
