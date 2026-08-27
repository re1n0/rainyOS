{
  mkTarget,
  inputs,
  ...
}:
mkTarget "hyprland" {
  tags = ["gui" "hyprland"];
  description = "Hyprland tiling window manager";

  nixos = _: {
    programs.hyprland.enable = true;
  };

  hm = {
    config,
    pkgs,
    ...
  }: {
    systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];

    xdg.portal = {
      extraPortals = [pkgs.xdg-desktop-portal-hyprland];
      configPackages = [config.wayland.windowManager.hyprland.package];
      config.hyprland.default = [
        "hyrpland"
        "wlr"
        "gtk"
      ];
    };

    services.hyprpolkitagent.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };

      xwayland.enable = true;

      settings = inputs.import-tree [
        ./_config
      ];
    };
  };
}
