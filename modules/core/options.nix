{ lib, config, ... }:
with lib;
{
  options.rainyos = with types; {
    configuration = mkOption {
      type = enum [
        "server"
        "desktop"
        "iso"
      ];
      description = "Sets defaults for other options based on selected value";
    };

    # GUI
    gui = {
      enable = mkOption {
        type = bool;
        example = false;
        description = "Enable graphical interface";
      };

      primaryMonitor = mkOption {
        type = int;
        default = 0;
        example = 1;
        description = "Primary monitor from `gui.monitors` list";
      };
    };

    gui.monitors = mkOption {
      type = listOf (submodule {
        options = {
          connector = mkOption {
            type = str;
            example = "DP-1";
            description = "Monitor connector";
          };

          width = mkOption {
            type = int;
            example = 1920;
            description = "Monitor width";
          };

          height = mkOption {
            type = int;
            example = 1080;
            description = "Monitor height";
          };

          refresh = mkOption {
            type = float;
            example = 60.0;
            description = "Monitor refresh rate";
          };

          position = mkOption {
            type = str;
            default = "0x0";
            example = "1920x0";
            description = "Monitor position ({px}x{px})";
          };

          scale = mkOption {
            type = float;
            default = 1.0;
            example = 1.5;
            description = "Monitor scale";
          };

          wide_color = mkEnableOption "Monitor supports wide (10bit) color";

          hdr = mkEnableOption "Monitor supports HDR";
        };
      });
      default = [ ];
      description = "Monitors settings";
    };

    gui.hyprland = {
      enable = mkOption {
        type = bool;
        example = false;
        description = "Enable Hyprland";
      };
    };

    # Security
    security = {
      clamav = {
        enable = mkOption {
          type = bool;
          example = false;
          description = "Enable ClamAV";
        };
      };
    };

    secureBoot.enable = mkEnableOption "Enable secure boot via lanzaboote";

    # Devices
    audio.enable = mkOption {
      type = bool;
      example = false;
      description = "Enable audio server";
    };

    bluetooth.enable = mkOption {
      type = bool;
      example = false;
      description = "Enable Bluetooth";
    };

    rt.enable = mkEnableOption "Enable Ray Tracing support";

    ssh = {
      enable = mkEnableOption "Enable SSH server";

      passwordAuth = mkEnableOption "Allows password authentication";

      authorizedKeys = mkOption {
        type = listOf str;
        default = [ ];
        description = "List of authorized keys for SSH";
      };
    };

    # System
    ananicy.enable = mkEnableOption "Enable ananicy daemon";

    powerManagement.enable = mkEnableOption "Enable power management";

    locales = {
      default = mkOption {
        type = str;
        default = "en_US.UTF-8";
        example = "de_DE.UTF-8/UTF-8";
        description = "Default locale";
      };

      supported = mkOption {
        type = listOf str;
        default = [ "en_US.UTF-8/UTF-8" ];
        example = [
          "en_US.UTF-8/UTF-8"
          "de_DE.UTF-8/UTF-8"
        ];
        description = "Additional supported locales (BEWARE: requires a different format with the added /UTF-8)";
      };
    };

    locales.extraSettings = {
      ctype = mkOption {
        type = str;
        description = "Character classification locale";
      };

      address = mkOption {
        type = str;
        description = "Address formatting locale";
      };

      identification = mkOption {
        type = str;
        description = "Identification formatting locale";
      };

      measurement = mkOption {
        type = str;
        description = "Measurement formatting locale";
      };

      messages = mkOption {
        type = str;
        description = "Messages formatting locale";
      };

      monetary = mkOption {
        type = str;
        description = "Monetary formatting locale";
      };

      name = mkOption {
        type = str;
        description = "Name formatting locale";
      };

      numeric = mkOption {
        type = str;
        description = "Numeric formatting locale";
      };
      paper = mkOption {
        type = str;
        description = "Paper sizes locale";
      };

      telephone = mkOption {
        type = str;
        description = "Telephone formatting locale";
      };

      time = mkOption {
        type = str;
        description = "Time formatting locale";
      };

      collate = mkOption {
        type = str;
        description = "Collate formatting locale";
      };
    };

    keymap = {
      console = mkOption {
        type = str;
        default = "us";
        example = "de";
        description = "Keymap for usage in console";
      };

      supported = mkOption {
        type = listOf str;
        example = [
          "us"
          "de"
        ];
        description = "Keymaps supported by the WM";
      };
    };

    tz = {
      static = mkOption {
        type = str;
        default = "Europe/Amsterdam";
        example = "America/Detroit";
        description = "System timezone";
      };
      automatic = mkEnableOption "Enable a daemon that'll update timezone based on your localization by utilising geoclue2";
    };

    # Git
    git = {
      username = mkOption {
        type = str;
        default = "";
        example = "Joe Doe";
        description = "Git username";
      };
      email = mkOption {
        type = str;
        example = "joe@doe.com";
        description = "Git Email";
      };
      signingKey = mkOption {
        type = str;
        description = "Git signing key";
      };
    };

    # Music
    mpd = {
      enable = mkEnableOption "Enable MPD service";
      rmpc = mkOption {
        type = bool;
        example = false;
        description = "Enable TUI client for MPD";
      };
      mpris = mkOption {
        type = bool;
        example = true;
        description = "Enable MPRIS protocol support for MPD";
      };
    };

    # Games
    gaming.gamescope.enable = mkEnableOption "Enable Gamescope";

    gaming.steam = {
      enable = mkEnableOption "Enable Steam";
      session = mkOption {
        type = bool;
        example = true;
        description = "Enable Steam's Gamescope session";
      };
      rocksmithPatch = mkEnableOption "Adds optional script for patching Rocksmith 2014";
    };

    gaming.opengamepadui = {
      enable = mkEnableOption "Enable OpenGamepadUI";
      session = mkOption {
        type = bool;
        example = true;
        description = "Enable OpenGamepadUI's Gamescope session";
      };
    };

    # Virtualisation
    virtualisation.podman.enable = mkEnableOption "Enable Podman";

    # Wine
    wine.enable = mkOption {
      type = bool;
      example = true;
      description = "Enable Wine";
    };

    # GPG
    gpg.enable = mkOption {
      type = bool;
      example = true;
      description = "Enable GPG and pinentry";
    };
  };

  config =
    let
      cfg = config.rainyos;
      defaultLocale = cfg.locales.default;
      mpdEnabled = cfg.mpd.enable;
      isDesktop = cfg.configuration == "desktop";
    in
    {
      # GUI
      rainyos.gui.enable = mkDefault isDesktop;
      rainyos.gui.hyprland.enable = mkDefault cfg.gui.enable;

      # System
      rainyos.locales.extraSettings = {
        ctype = mkDefault defaultLocale;
        address = mkDefault defaultLocale;
        identification = mkDefault defaultLocale;
        measurement = mkDefault defaultLocale;
        messages = mkDefault defaultLocale;
        monetary = mkDefault defaultLocale;
        name = mkDefault defaultLocale;
        numeric = mkDefault defaultLocale;
        paper = mkDefault defaultLocale;
        telephone = mkDefault defaultLocale;
        time = mkDefault defaultLocale;
        collate = mkDefault defaultLocale;
      };

      # Security
      rainyos.security.clamav.enable = mkDefault isDesktop;

      # Devices
      rainyos.audio.enable = mkDefault isDesktop;

      rainyos.bluetooth.enable = mkDefault isDesktop;

      rainyos.keymap.supported = mkDefault [ cfg.keymap.console ];

      hardware.nvidia-container-toolkit.enable = mkDefault (
        config.hardware.nvidia.enabled && cfg.virtualisation.podman.enable
      );

      # Music
      rainyos.mpd = {
        rmpc = mkDefault mpdEnabled;
        mpris = mkDefault mpdEnabled;
      };

      # Gaming
      rainyos.gaming.steam.session = mkDefault cfg.gaming.gamescope.enable;
      rainyos.gaming.opengamepadui.session = mkDefault cfg.gaming.gamescope.enable;

      # Virtualisation
      rainyos.virtualisation.podman.enable = mkDefault isDesktop;

      # Wine
      rainyos.wine.enable = mkDefault isDesktop;

      # GPG
      rainyos.gpg.enable = mkDefault isDesktop;
    };
}
