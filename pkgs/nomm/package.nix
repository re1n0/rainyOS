{
  lib,
  python3Packages,
  gtk4,
  libadwaita,
  unrar,
  wrapGAppsHook4,
  gobject-introspection,
  libnotify,
  sources,
}:
python3Packages.buildPythonApplication {
  pname = "nomm";
  version = "unstable-2026-03-22";

  format = "other";

  src = sources.nomm;

  nativeBuildInputs = [
    wrapGAppsHook4
    gobject-introspection
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

  makeWrapperArgs = [
    "--prefix PATH : ${lib.makeBinPath [ unrar ]}"
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/nomm $out/bin
    cp -r assets default_game_configs src $out/share/nomm/

    cat > $out/bin/nomm <<EOF
    #!/usr/bin/env python3
    import os
    import sys
    import runpy

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
