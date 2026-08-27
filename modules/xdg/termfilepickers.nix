{
  mkTarget,
  inputs,
  ...
}:
mkTarget "termfilepickers" {
  tags = ["xdg" "tui"];
  description = "xdg desktop portal for terminal file picker";

  hm = {pkgs, ...}: {
    xdg.portal.config.common = {
      default = [
        "termfilepickers"
      ];
      "org.freedesktop.impl.portal.FileChooser" = ["termfilepickers"];
    };

    services.xdg-desktop-portal-termfilepickers = let
      termfilepickers = inputs.xdp-termfilepickers.packages.${pkgs.system}.default.override {
        replaceYazi = false;
      };
    in {
      enable = true;
      package = termfilepickers;
    };
  };
}
