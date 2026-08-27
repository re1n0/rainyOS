{mkTarget, ...}:
mkTarget "plymouth" {
  tags = ["splash"];
  description = "Plymouth boot splash image";

  nixos = {
    boot = {
      plymouth.enable = true;
      kernelParams = [
        "splash"
      ];
    };
  };
}
