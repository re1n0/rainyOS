{ pkgs, modulesPath, ... }:
{
  imports = [
    ../../modules/core
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  environment.systemPackages = with pkgs; [
    git
    rainy-install
  ];

  rainyos = {
    configuration = "iso";

    locales = {
      default = "en_US.UTF-8";
      supported = [
        "en_US.UTF-8/UTF-8"
      ];
    };

    keymap.console = "us";

    ssh = {
      enable = true;
      passwordAuth = true;
    };
  };
}
