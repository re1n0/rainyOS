{ pkgs
, config
, lib
, ...
}:
let
  cfg = config.rainyos.gui;
in
lib.mkIf cfg.enable {
  programs.hyprland.enable = cfg.hyprland.enable;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${lib.getExe pkgs.tuigreet} \
                    -t --time-format '%I:%M %p | %a • %h | %F' \
                    -g 'Access is restricted to authorized personel only.'
        '';
      };
    };
  };
}
