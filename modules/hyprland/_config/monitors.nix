{
  lib,
  osConfig,
  ...
}: {
  monitor = let
    displays = osConfig.rainy.settings.displays;

    modeStr = d:
      if d.resolution == null
      then "preferred"
      else "${d.resolution}@${d.refresh}";

    mkMonitor = d:
      lib.filterAttrs (_: v: v != null) {
        output = d.connector;
        mode = modeStr d;
        inherit (d) position;
        inherit (d) scale;
        inherit (d) cm;
        sdr_eotf = d.eotf;
        icc =
          if d.icc == null
          then null
          else toString d.icc;
        supports_hdr =
          if d.hdr
          then 1
          else null;
        supports_wide_color =
          if d.wide_color
          then 1
          else null;
      };
  in
    map mkMonitor displays;
}
