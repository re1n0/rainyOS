{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.rainyos.gaming;
  common = import ./common.nix { inherit config lib; };
in
lib.mkIf cfg.steam.enable {
  programs.steam = {
    enable = true;

    extraCompatPackages = with pkgs; [
      proton-cachyos-x86_64-v3
    ];

    package = pkgs.millennium-steam.override {
      extraPkgs =
        _: with pkgs; [
          close-steam-session
          wineWow64Packages.stable
          pipeasio
        ];
      extraLibraries =
        _: with pkgs; [
          pipeasio
        ];
    };

    extest.enable = true;
    protontricks.enable = true;

    rocksmithPatch = lib.mkIf cfg.steam.rocksmithPatch {
      enable = true;

      pipeasio = {
        inputDevice = "alsa_input.usb-BEHRINGER_UMC404HD_192k-00.HiFi__Mic2__source";
        outputDevice = "alsa_output.usb-BEHRINGER_UMC404HD_192k-00.HiFi__Line1__sink";
      };
    };
  };

  programs.steam.gamescopeSession = lib.mkIf cfg.steam.session {
    enable = true;
    args = common.makeGamescopeArgs [ ];
    steamArgs = [
      "-console"
      "-pipewire-dmabuf"
      "-steamos3"
      "-gamepadui"
    ];
  };

  programs.gamemode = {
    enable = true;

    enableRenice = true;

    settings = {
      general = {
        renice = 20;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vulkan-helper
    freetype
  ];
}
