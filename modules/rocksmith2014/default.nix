{mkTarget, ...}:
mkTarget "rocksmith2014" {
  tags = ["gaming" "rocksmith2014"];
  description = "Patch for Rocksmith 2014";

  nixos = {
    config,
    pkgs,
    ...
  }: {
    programs.steam.rocksmithPatch.enable = true;

    programs.steam.extraPackages = with pkgs; [wineWow64Packages pipeasio];

    security.rtkit.enable = true;

    boot.kernelParams = [
      "snd-seq"
      "snd-rawmidi"
    ];

    environment.systemPackages = with pkgs; [
      rtaudio
    ];

    security.pam.loginLimits = [
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "99";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "soft";
        value = "99999";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "hard";
        value = "99999";
      }
    ];

    users.users.${config.rainy.settings.username}.extraGroups = ["audio" "rtkit"];
  };
}
