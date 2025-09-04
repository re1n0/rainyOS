let
  makePkg = pkgs: name: pkgs.callPackage "${name}/package.nix" { };
in
final: prev: {
  nix-hash-git = makePkg final ./nix-hash-git;
  patch-rocksmith = makePkg final ./patch-rocksmith;
  themes = makePkg final ./themes;
  screenshot = makePkg final ./screenshot;
  close-steam-session = makePkg final ./close-steam-session;
  rainy-install = makePkg final ./rainy-install;
}
