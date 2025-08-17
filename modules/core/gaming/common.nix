{
  config,
  lib,
  ...
}:
let
  cfg = config.rainyos;
  primaryMonitor = builtins.elemAt cfg.gui.monitors cfg.gui.primaryMonitor;
  gamescopeArgs = [
    "-f"
    "-W ${builtins.toString primaryMonitor.width}"
    "-H ${builtins.toString primaryMonitor.height}"
    "-r ${builtins.toString primaryMonitor.refresh}"
  ]
  ++ (lib.optional cfg.rt.enable "--rt")
  ++ (lib.optionals cfg.hdr.enable [
    "--hdr-enable"
    "--hdr-itm-enable"
  ]);
in
{
  inherit gamescopeArgs;
}
