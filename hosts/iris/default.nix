{ ... }:
{
  imports = [
    ../../modules/core
    ./hardware.nix
    ./partitioning.nix
  ];

  facter.reportPath = ./facter.json;

  rainyos = {
    configuration = "desktop";

    secureBoot.enable = true;

    gui.enable = true;
    gui.monitors = [
      {
        connector = "HDMI-A-1";
        width = 2560;
        height = 1440;
        refresh = 144.0;
        wide_color = true;
        hdr = true;
      }
    ];

    audio.enable = true;

    bluetooth.enable = false;

    tz.static = "Europe/Amsterdam";

    locales = {
      default = "en_US.UTF-8";
      supported = [
        "en_US.UTF-8/UTF-8"
        "de_DE.UTF-8/UTF-8"
        "pl_PL.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
      extraSettings = {
        ctype = "en_US.UTF-8";
        address = "de_DE.UTF-8";
        identification = "de_DE.UTF-8";
        measurement = "de_DE.UTF-8";
        messages = "en_US.UTF-8";
        monetary = "de_DE.UTF-8";
        name = "de_DE.UTF-8";
        numeric = "en_US.UTF-8";
        paper = "de_DE.UTF-8";
        telephone = "de_DE.UTF-8";
        time = "de_DE.UTF-8";
        collate = "de_DE.UTF-8";
      };
    };

    keymap = {
      console = "us";
      supported = [
        "us"
        "de"
        "pl"
      ];
    };

    git = {
      username = "Rein";
      email = "rein@rein.icu";
      signingKey = "66A8170622279BD9586ACEDD5B29A8813F4765C4";
    };

    mpd.enable = true;

    gaming = {
      gamescope.enable = true;

      steam = {
        enable = true;
        session = true;
        rocksmithPatch = true;
      };
    };

    virtualisation.podman.enable = true;
  };
}
