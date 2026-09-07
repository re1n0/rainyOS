{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.rainyos.gpg.enable {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-egui;
  };
}
