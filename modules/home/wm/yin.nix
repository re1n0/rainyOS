{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.packages = [ pkgs.yin ];

  systemd.user.services.yin = {
    Install = {
      WantedBy = [ config.wayland.systemd.target ];
    };

    Unit = {
      ConditionEnvironment = "WAYLAND_DISPLAY";
      Description = "yin daemon";
      After = [ config.wayland.systemd.target ];
      PartOf = [ config.wayland.systemd.target ];
    };

    Service = {
      ExecStart = "${lib.getExe' pkgs.yin "yin"}";
      Restart = "always";
      RestartSec = 10;
    };
  };
}
