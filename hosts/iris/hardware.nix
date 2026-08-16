_: {
  hardware.nvidia = {
    open = true;

    modesetting.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia.branch = "bleeding_edge";

  mesa-git = {
    enable = true;
    drivers = ["nvidia"];
  };
}
