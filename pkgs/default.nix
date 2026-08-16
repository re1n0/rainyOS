{inputs}: let
  makePkg = pkgs: name: pkgs.callPackage "${name}/package.nix" {};
in
  final: prev: {
    pins = import ../npins;

    buildFishPlugin = makePkg final ./build-fish-plugin;

    rainy-install = makePkg final ./rainy-install;
    screenshot = makePkg final ./screenshot;
    themes = makePkg final ./themes;

    yaziPlugins = prev.lib.recursiveUpdate prev.yaziPlugins {
      gvfs = makePkg final ./gvfs.yazi;
    };

    fishPlugins = prev.lib.recursiveUpdate prev.fishPlugins {
      fifc-git = prev.fishPlugins.fifc.overrideDerivation (_: {
        src = final.pins.fifc;
        version = final.pins.fifc.version;
      });
    };

    graalvmPackages = prev.lib.recursiveUpdate prev.graalvmPackages {
      graalvm-oracle_21 = makePkg final ./graalvm-oracle_21;
    };

    freecad-fix = makePkg final ./freecad-fix;

    winetricks = final.winetricks-git;
    nomm = makePkg final ./nomm;

    sheetui = inputs.sheetsui.packages.${prev.stdenv.hostPlatform.system}.default;
  }
