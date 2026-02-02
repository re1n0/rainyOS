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
        graalvmPackages.graalvm-ce
        graalvmPackages.graalvm-oracle_21
        temurin-bin
      ];
    })
  ];
}
