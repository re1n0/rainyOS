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
        graalvmPackages.graalvm-oracle
        graalvmPackages.graalvm-oracle_21
        temurin-bin
      ];
    })
  ];
}
