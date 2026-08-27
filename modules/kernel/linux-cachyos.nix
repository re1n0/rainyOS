{
  mkTarget,
  inputs,
  ...
}:
mkTarget "linux-cachyos" {
  tags = ["performance"];
  description = "CachyOS Linux kernel built for x86_64-v3";

  nixos = {pkgs, ...}: {
    boot.kernelPackages =
      inputs.nix-cachyos-kernel.packages.${pkgs.stdenv.hostPlatform.system}.linuxPackages-cachyos-latest-lto-x86_64-v3;
  };
}
