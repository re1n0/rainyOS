{
  config,
  lib,
  ...
}:
let
  cfg = config.rainyos.gaming;
  common = import ./common.nix { inherit config lib; };
in
lib.mkIf cfg.opengamepadui.enable {
  programs.opengamepadui = {
    enable = true;

    inputplumber.enable = true;

    powerstation.enable = config.rainyos.powerManagement.enable;
  };

  programs.opengamepadui.gamescopeSession = lib.mkIf cfg.opengamepadui.session {
    enable = true;
    args = common.makeGamescopeArgs [
      "--xwayland-count"
      "2"
      "--default-touch-mode"
      "4"
      "--hide-cursor-delay"
      "1000"
      "--fade-out-duration"
      "200"
      "--steam"
    ];
  };
}
