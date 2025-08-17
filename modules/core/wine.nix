{ pkgs, ... }:
{
  programs.wine = {
    enable = true;
    package = pkgs.wine-wayland;
    binfmt = true;
    ntsync = true;
  };
}
