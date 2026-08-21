{
  pkgs,
  config,
  ...
}: {
  hardware.nvidia = {
    open = true;

    modesetting.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  # hardware.nvidia.branch = "bleeding_edge";

  hardware.nvidia.package = let
    base = (pkgs.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.latest;
  in
    base.overrideAttrs (old: {
      passthru =
        old.passthru
        // {
          open = old.passthru.open.overrideAttrs (o: {
            patches = (o.patches or []) ++ [./nvidia-open-gpio-device-const.patch];
          });
        };
    });

  mesa-git = {
    enable = true;
    drivers = ["nvidia"];
  };
}
