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
    ferium

    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];

      jdks = [
        temurin-jre-bin-17
        temurin-jre-bin
        graalvmPackages.graalvm-oracle_21
        graalvmPackages.graalvm-oracle
      ];
    })
  ];
}
