{
  lib,
  config,
  ...
}:
lib.mkIf config.rainyos.security.clamav.enable {
  services = {
    clamav = {
      daemon.enable = true;
      updater.enable = true;
      fangfrisch.enable = true;
    };
  };

  /*
    security.sudo = {
      package = pkgs.sudo.override { withInsults = true; };
      extraConfig = # sudo
        ''
          Defaults lecture = never
          Defaults insults
        '';
    };
  */

  security.sudo.enable = false;

  security.sudo-rs = {
    enable = true;
    execWheelOnly = true;
  };

  security.rtkit.enable = true;
}
