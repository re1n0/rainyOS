{mkTarget, ...}:
mkTarget "ananicy" {
  tags = ["gaming" "performance"];
  description = "Ananicy nice daemon";

  nixos = {pkgs, ...}: {
    services.ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };
  };
}
