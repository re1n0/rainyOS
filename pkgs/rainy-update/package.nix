{
  lib,
  python3Packages,
  git,
  nix,
  nix-update,
  nix-prefetch-git,
  nixpkgs-review,
  yarn-berry,
  pyforgejo,
}:
python3Packages.buildPythonApplication {
  pname = "rainy-update";
  version = "0.1.0";
  pyproject = true;

  src = ./package;

  build-system = with python3Packages; [
    setuptools
  ];

  dependencies = with python3Packages; [
    (toPythonModule nix-update)
    pygithub
    pyforgejo
  ];

  makeWrapperArgs = [
    "--prefix"
    "PATH"
    ":"
    (lib.makeBinPath [
      git
      nix
      nix-prefetch-git
      nixpkgs-review
      yarn-berry.yarn-berry-fetcher
    ])
  ];

  meta = {
    description = "Batch-run passthru.updateScript for flake packages and commit per nixpkgs convention";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [rein];
    mainProgram = "rainy-update";
  };
}
