{ config
, lib
, pkgs
, ...
}:
let
  common = import ./common.nix { inherit config lib; };
in
lib.mkIf config.rainyos.gaming.gamescope.enable {
  programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = common.makeGamescopeArgs [ ];
    package = pkgs.gamescope_git;
  };
}
