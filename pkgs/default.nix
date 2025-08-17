let
  makePkg = pkgs: name: pkgs.callPackage "${name}/package.nix" { };
in
final: prev: {
  nix-hash-git = makePkg final ./nix-hash-git;
  patch-rocksmith = makePkg final ./patch-rocksmith;
  themes = makePkg final ./themes;
  tukai = makePkg final ./tukai;
  screenshot = makePkg final ./screenshot;
}
