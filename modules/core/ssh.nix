{ config, lib, ... }:
let
  cfg = config.rainyos.ssh;
in
lib.mkIf cfg.enable {
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = cfg.passwordAuth;
      KbdInteractiveAuthentication = cfg.passwordAuth;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
