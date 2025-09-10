let
  makePkg = pkgs: name: pkgs.callPackage "${name}/package.nix" { };
in
final: prev: {
  nix-hash-git = makePkg final ./nix-hash-git;
  nix-hash-url = makePkg final ./nix-hash-url;
  patch-rocksmith = makePkg final ./patch-rocksmith;
  rs-autoconnect = makePkg final ./rs-autoconnect;
  themes = makePkg final ./themes;
  screenshot = makePkg final ./screenshot;
  close-steam-session = makePkg final ./close-steam-session;
  rainy-install = makePkg final ./rainy-install;
  yin = makePkg final ./yin;
  sysinfo = makePkg final ./sysinfo;
}
