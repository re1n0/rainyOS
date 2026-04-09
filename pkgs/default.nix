let
  makePkg = pkgs: name: pkgs.callPackage "${name}/package.nix" { };
in
final: prev: {
  pins = import ../npins;

  nix-hash-git = makePkg final ./nix-hash-git;
  nix-hash-url = makePkg final ./nix-hash-url;

  rainy-install = makePkg final ./rainy-install;
  screenshot = makePkg final ./screenshot;
  themes = makePkg final ./themes;

  steam = makePkg final ./steam;
  close-steam-session = makePkg final ./close-steam-session;

  yaziPlugins = prev.lib.recursiveUpdate prev.yaziPlugins { gvfs = makePkg final ./gvfs.yazi; };

  graalvmPackages = prev.lib.recursiveUpdate prev.graalvmPackages {
    graalvm-oracle_21 = makePkg final ./graalvm-oracle_21;
  };

  freecad-fix = makePkg final ./freecad-fix;

  winetricks = final.winetricks-git;
  nomm = makePkg final ./nomm;
}
