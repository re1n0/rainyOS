{ inputs }:
let
  makePkg = pkgs: name: pkgs.callPackage "${name}/package.nix" { };
in
final: prev: {
  hyprland = inputs.hyprland.packages.${prev.system}.hyprland;
  xdg-desktop-portal-hyprland = inputs.hyprland.packages.${prev.system}.xdg-desktop-portal-hyprland;
  hyprlandPlugins = prev.lib.recursiveUpdate prev.hyprlandPlugins {
    hypr-dynamic-cursors = inputs.hypr-dynamic-cursors.packages.${prev.system}.hypr-dynamic-cursors;
  };

  nix-hash-git = makePkg final ./nix-hash-git;
  nix-hash-url = makePkg final ./nix-hash-url;

  rainy-install = makePkg final ./rainy-install;
  screenshot = makePkg final ./screenshot;
  themes = makePkg final ./themes;

  steam = makePkg final ./steam;
  winetricks = makePkg final ./winetricks;
  close-steam-session = makePkg final ./close-steam-session;

  yaziPlugins = prev.lib.recursiveUpdate prev.yaziPlugins { gvfs = makePkg final ./gvfs.yazi; };

  yin = makePkg final ./yin;
  sysinfo = makePkg final ./sysinfo;
}
