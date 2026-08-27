{mkTarget, ...}:
mkTarget "nvidia-open" {
  tags = ["nvidia-gpu"];
  description = "NVIDIA open driver";

  nixos = {
    lib,
    pkgs,
    config,
    ...
  }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [nvidia-vaapi-driver];
      extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
    };

    hardware.nvidia = {
      open = true;

      modesetting.enable = true;

      nvidiaSettings = false;

      # branch = "bleeding_edge";

      package = let
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
    };

    services.xserver.videoDrivers = ["nvidia"];

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "nvidia-x11"
      ];
  };
}
