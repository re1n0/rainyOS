{
  pkgs,
  lib,
  os,
  inputs,
  ...
}: let
  mimeApps = import ./mimeapps.nix;
  desktopEntries = import ./apps.nix;
  inherit (os.gui) hyprland;
in {
  imports = [
    ./handlr.nix
    inputs.xdp-termfilepickers.homeManagerModules.default
  ];
  xdg = {
    enable = true;
    userDirs.enable = true;

    inherit mimeApps desktopEntries;
  };

  xdg.portal = lib.mkIf os.gui.enable {
    enable = lib.mkForce true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs;
      [
        xdg-desktop-portal-wlr
      ]
      ++ (
        if hyprland.enable
        then [pkgs.xdg-desktop-portal-hyprland]
        else []
      );
    config = {
      common = {
        default =
          lib.optional hyprland.enable "hyprland"
          ++ [
            "termfilepickers"
            "wlr"
            "gtk"
          ];
        "org.freedesktop.impl.portal.FileChooser" = ["termfilepickers"];
      };
    };
  };

  services.xdg-desktop-portal-termfilepickers = let
    termfilepickers = inputs.xdp-termfilepickers.packages.${pkgs.system}.default.override {
      replaceYazi = false;
    };
  in {
    enable = true;
    package = termfilepickers;
    config = {
      terminal_command = [(lib.getExe pkgs.ghostty) "-e"];
    };
  };
}
