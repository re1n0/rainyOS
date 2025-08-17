{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.rainyos;
in
{
  documentation.nixos.enable = false;

  services.automatic-timezoned.enable = cfg.tz.automatic;
  time.timeZone = lib.mkIf (!cfg.tz.automatic) cfg.tz.static;

  i18n.defaultLocale = cfg.locales.default;
  i18n.supportedLocales = cfg.locales.supported;
  i18n.extraLocaleSettings = {
    LC_CTYPE = cfg.locales.extraSettings.ctype;
    LC_ADDRESS = cfg.locales.extraSettings.address;
    LC_IDENTIFICATION = cfg.locales.extraSettings.identification;
    LC_MEASUREMENT = cfg.locales.extraSettings.measurement;
    LC_MESSAGES = cfg.locales.extraSettings.messages;
    LC_MONETARY = cfg.locales.extraSettings.monetary;
    LC_NAME = cfg.locales.extraSettings.name;
    LC_NUMERIC = cfg.locales.extraSettings.numeric;
    LC_PAPER = cfg.locales.extraSettings.paper;
    LC_TELEPHONE = cfg.locales.extraSettings.telephone;
    LC_TIME = cfg.locales.extraSettings.time;
    LC_COLLATE = cfg.locales.extraSettings.collate;
  };

  console = {
    keyMap = cfg.keymap.console;
    font = "${pkgs.kbd}/share/consolefonts/ruscii_8x16.psfu.gz";
  };

  system.stateVersion = "25.11"; # DO NOT CHANGE!
}
