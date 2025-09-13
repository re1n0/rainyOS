{ config
, pkgs
, lib
, ...
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
      proton-cachyos
      proton-ge-custom
    ];

    package = (if cfg.steam.rocksmithPatch then pkgs.steamRocksmith else pkgs.steam).override {
      extraPkgs =
        pkgs': with pkgs'; [ close-steam-session ] ++ (lib.optional cfg.steam.rocksmithPatch wineasio);
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
  ];
}
