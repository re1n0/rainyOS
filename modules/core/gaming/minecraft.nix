{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.rainyos.gaming;
in
lib.mkIf cfg.minecraft.enable {
  environment.systemPackages = with pkgs; [
    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];

      jdks = [
        temurin-jre-bin-21
        temurin-jre-bin
      ];
    })
  ];
}
