{
  lib,
  python3Packages,
  gtk4,
  libadwaita,
  unrar,
  wrapGAppsHook4,
  gobject-introspection,
  libnotify,
  pins,
  makeDesktopItem,
  copyDesktopItems,
}:
let
  inherit (pins) nomm;
in
python3Packages.buildPythonApplication {
  pname = "nomm";
  inherit (nomm) version;

  format = "other";

  src = nomm;

  nativeBuildInputs = [
    wrapGAppsHook4
    gobject-introspection
    copyDesktopItems
  ];

  buildInputs = [
    gtk4
    libadwaita
    libnotify
  ];

  dependencies = with python3Packages; [
    pygobject3
    requests
    pyyaml
    rarfile
    python-unrar
    vdf
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "nomm";
      desktopName = "Nomm";
      exec = "nomm %u";
      icon = "nomm";
      terminal = false;
      mimeTypes = [ "x-scheme-handler/nxm" ];
      categories = [
        "Game"
        "Utility"
      ];
    })
  ];

  makeWrapperArgs = [
    "--prefix PATH : ${lib.makeBinPath [ unrar ]}"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/nomm $out/bin
    cp -r assets default_game_configs src $out/share/nomm/

    cat > $out/bin/nomm <<EOF
    #!/usr/bin/env python3
    import os
    import sys
    import runpy
    import shutil

    config_dir = os.path.expanduser("~/.local/share/nomm/game_configs")
    if os.path.exists(config_dir):
        for root, dirs, files in os.walk(config_dir):
            for d in dirs:
                try: os.chmod(os.path.join(root, d), 0o755)
                except Exception: pass
            for f in files:
                try: os.chmod(os.path.join(root, f), 0o644)
                except Exception: pass

    _orig_copytree = shutil.copytree
    def _copytree_writable(*args, **kwargs):
        res = _orig_copytree(*args, **kwargs)
        for root, dirs, files in os.walk(res):
            for d in dirs: os.chmod(os.path.join(root, d), 0o755)
            for f in files: os.chmod(os.path.join(root, f), 0o644)
        return res
    shutil.copytree = _copytree_writable

    _orig_copy = shutil.copy
    def _copy_writable(*args, **kwargs):
        res = _orig_copy(*args, **kwargs)
        if os.path.isfile(res): os.chmod(res, 0o644)
        return res
    shutil.copy = _copy_writable
    shutil.copy2 = _copy_writable

    os.chdir("$out/share/nomm")
    sys.path.insert(0, "$out/share/nomm/src")

    runpy.run_path("src/launcher.py", run_name="__main__")
    EOF

    chmod +x $out/bin/nomm

    runHook postInstall
  '';

  meta = {
    description = "Native Open Mod Manager";
    homepage = "https://github.com/Allexio/nomm";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ rein ];
    mainProgram = "nomm";
  };
}
