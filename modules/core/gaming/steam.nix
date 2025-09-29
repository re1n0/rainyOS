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
      luxtorpeda
      proton-cachyos_x86_64_v4
      proton-ge-custom
    ];

    package = pkgs.steam.override {
      extraLibraries =
        pkgs':
        with pkgs';
        (lib.optionals cfg.steam.rocksmithPatch [
          pipewire.jack
          rs-autoconnect
        ]);
      extraPkgs =
        pkgs':
        with pkgs';
        (lib.optionals cfg.steam.rocksmithPatch [
          patch-rocksmith
          wineasio
        ]);
    };

    # extest.enable = true;
    protontricks.enable = true;

    rocksmithPatch.enable = cfg.steam.rocksmithPatch;
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
    nexusmods-app
    freetype
  ];
}
