{mkTarget, ...}:
mkTarget "linux-cachyos" {
  tags = ["performance"];
  description = "CachyOS Linux kernel built for x86_64-v3";
  platforms = ["x86_64-linux"];

  nixos = {pkgs, ...}: {
    boot.kernelPackages =
      pkgs.linuxPackages-cachyos-rainy;
  };
}
