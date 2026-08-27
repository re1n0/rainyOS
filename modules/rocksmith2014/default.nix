{mkTarget, ...}:
mkTarget "rocksmith2014" {
  tags = ["gaming" "rocksmith2014"];
  description = "Patch for Rocksmith 2014";
  platforms = ["x86_64-linux"];

  nixos = {
    config,
    pkgs,
    ...
  }: {
    programs.steam.rocksmithPatch.enable = true;

    programs.steam.extraPackages = with pkgs; [wineWow64Packages pipeasio];

    security.rtkit.enable = true;

    boot.kernelModules = ["snd-seq" "snd-rawmidi"];
    boot.kernelParams = ["threadirqs"];

    users.users.${config.rainy.settings.username}.extraGroups = ["audio" "rtkit"];
  };
}
