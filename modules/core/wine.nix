{ pkgs
, lib
, config
, ...
}:
lib.mkIf config.rainyos.wine.enable {
  programs.wine = {
    enable = true;
    package = pkgs.wine-wayland;
    binfmt = true;
    ntsync = true;
  };
}
