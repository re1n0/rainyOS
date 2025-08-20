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
      proton-cachyos
      proton-ge-custom
    ];

    package = pkgs.steam.override {
      extraLibraries = pkgs': with pkgs'; (lib.optional cfg.steam.rocksmithPatch pipewire.jack);
      extraPkgs = pkgs': with pkgs'; (lib.optional cfg.steam.rocksmithPatch wineasio);
    };

    extest.enable = true;
    protontricks.enable = true;
  };

  programs.steam.gamescopeSession = lib.mkIf cfg.steam.session {
    enable = true;
    args = common.gamescopeArgs;
    steamArgs = [
      "-tenfoot"
      "-console"
      "-pipewire-dmabuf"
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

  environment.systemPackages = lib.optional cfg.steam.rocksmithPatch pkgs.patch-rocksmith;
}
