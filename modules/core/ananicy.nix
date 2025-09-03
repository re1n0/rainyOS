{ pkgs
, lib
, config
, ...
}:
lib.mkIf config.rainyos.ananicy.enable {
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos_git;
  };
}
