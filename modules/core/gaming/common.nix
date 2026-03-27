{
  config,
  lib,
  ...
}:
let
  cfg = config.rainyos;
  primaryMonitor = builtins.elemAt cfg.gui.monitors cfg.gui.primaryMonitor;
  makeGamescopeArgs =
    args:
    [
      "--prefer-output"
      "${primaryMonitor.connector},*"
      "--fullscreen"
      "--output-width"
      "${toString primaryMonitor.width}"
      "--output-height"
      "${toString primaryMonitor.height}"
      "--nested-refresh"
      "${toString primaryMonitor.refresh}"
      "--force-windows-fullscreen"
    ]
    ++ (lib.optional cfg.rt.enable "--rt")
    ++ (lib.optionals primaryMonitor.hdr [
      "--hdr-enable"
      "--hdr-itm-enable"
    ])
    ++ args;
in
{
  inherit makeGamescopeArgs;
}
