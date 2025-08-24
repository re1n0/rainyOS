{ config, ... }:
{
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/rainyOS";
  };

  programs.nh.clean = {
    enable = true;
    dates = "daily";
    extraArgs = "--keep-since 3d";
  };
}
