_: let
  makePkg = pkgs: name: pkgs.callPackage "${name}/package.nix" {};
in
  final: prev: {
    rainy-install = makePkg final ./rainy-install;
    screenshot = makePkg final ./screenshot;
    themes = makePkg final ./themes;

    oc-rsync = makePkg final ./oc-rsync;

    freecad-fix = makePkg final ./freecad-fix;

    winetricks = final.winetricks-git;
    nomm = makePkg final ./nomm;
  }
