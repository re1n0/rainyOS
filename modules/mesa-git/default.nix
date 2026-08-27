{mkTarget, ...}:
mkTarget "mesa-git" {
  tags = ["performance"];
  description = "Mesa 3D graphics library built from main branch";
  platforms = ["x86_64-linux"];

  nixos = {config, ...}: {
    drivers.mesa-git = {
      enable = true;
      protonPackage = config.compatTool.default;
    };
  };
}
