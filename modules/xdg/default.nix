{mkTarget, ...}:
mkTarget "xdg" {
  tags = ["xdg"];
  description = "Common interfaces for desktop environments";

  nixos = _: {
    environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
  };

  hm = {pkgs, ...}: {
    xdg = {
      enable = true;
      userDirs.enable = true;
      mimeApps.enable = true;
      autostart.enable = true;
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
      config.common = {
        default = [
          "wlr"
          "gtk"
        ];
      };
    };
  };
}
