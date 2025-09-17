let
  makePkg = pkgs: name: pkgs.callPackage "${name}/package.nix" { };
in
final: prev: {
  nix-hash-git = makePkg final ./nix-hash-git;
  nix-hash-url = makePkg final ./nix-hash-url;
  themes = makePkg final ./themes;
  screenshot = makePkg final ./screenshot;
  close-steam-session = makePkg final ./close-steam-session;
  rainy-install = makePkg final ./rainy-install;
  yin = makePkg final ./yin;
  sysinfo = makePkg final ./sysinfo;
  steam = makePkg final ./steam;
}
