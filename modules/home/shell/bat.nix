{ lib, pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      pager = "${lib.getExe pkgs.less} -FXR";
      style = "numbers,changes,header";
      italic-text = "always";
      decorations = "always";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      batpipe
    ];
  };
}
