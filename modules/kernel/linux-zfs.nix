{mkTarget, ...}:
mkTarget "linux-zfs" {
  tags = ["zfs"];
  description = "Linux kernel with ZFS support, for x86_64 servers";
  platforms = ["x86_64-linux"];

  nixos = {
    config,
    pkgs,
    ...
  }: {
    boot.kernelPackages =
      pkgs.linuxKernel.kernels.linux_latest;

    boot.zfs.package = config.boot.kernelPackages.zfs_2_4;
    boot.supportedFilesystems.zfs = true;
  };
}
