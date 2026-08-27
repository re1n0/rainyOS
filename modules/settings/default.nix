_: {
  flake.nixosModules.settings = {
    config,
    lib,
    ...
  }: {
    options.rainy.settings = {
      # keep-sorted start block=yes newline_separated=yes
      displays = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule {
          options = {
            # keep-sorted start block=yes newline_separated=yes
            cm = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              example = "dcip3";
              description = "Color management preset";
            };

            connector = lib.mkOption {
              type = lib.types.str;
              example = "DP-1";
              description = "Display connector";
            };

            eotf = lib.mkOption {
              type = lib.types.str;
              default = "default";
              example = "srgb";
              description = "SDR transfer function";
            };

            hdr = lib.mkEnableOption "Monitor supports HDR";

            position = lib.mkOption {
              type = lib.types.strMatching "^[0-9]+x[0-9]+$";
              default = "0x0";
              example = "1920x0";
              description = "Display position (VERTICALxHORIZONTAL)";
            };

            refresh = lib.mkOption {
              type = lib.types.int;
              example = 60;
              description = "Display refresh rate";
            };

            resolution = lib.mkOption {
              type = lib.types.nullOr (lib.types.strMatching "^[0-9]+x[0-9]+$");
              example = "1920x1080";
              description = "Display resolution (WIDTHxHEIGHT).";
            };

            scale = lib.mkOption {
              type = lib.types.float;
              default = 1.0;
              example = 1.5;
              description = "Display scale";
            };

            wide_color = lib.mkEnableOption "Display support for wide (10bit) color";
            # keep-sorted end
          };
          default = {};
        });

        keymap = {
          options = {
            console = lib.mkOption {
              type = lib.types.str;
              default = "us";
              description = "Default keymap used in console";
            };
            supported = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              description = "Keymaps supported by the DE/WM";
            };
          };
        };

        locales = {
          default = lib.mkOption {
            type = lib.types.strMatching "[a-z]{2}_[A-Z]{2}\\.[A-Z0-9-]+";
            default = "en_US.UTF-8/UTF-8";
            example = "de_DE.UTF-8/UTF-8";
            description = "Default locale";
          };
          extra = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = ["en_US.UTF-8/UTF-8"];
            example = [
              "en_US.UTF-8/UTF-8"
              "de_DE.UTF-8/UTF-8"
            ];
            description = "Additional supported locales";
          };
        };

        timezone = lib.mkOption {
          type = lib.types.str;
          default = "Europe/Amsterdam";
          example = "America/Detroit";
          description = "System timezone";
        };

        username = lib.mkOption {
          type = lib.types.str;
          default = "user";
        };
      };
      # keep-sorted end
    };

    config = let
      cfg = config.rainy.settings;
    in {
      rainy.settings.keymap.supported = [cfg.keymap.default];

      console.keyMap = cfg.keymap.default;

      i18n = let
        locale = lib.strings.splitString "/" cfg.locales.default;
      in {
        defaultLocale = lib.elemAt 0 locale;
        defaultCharset = lib.elemAt 1 locale;
        extraLocales = cfg.locales.extra;
      };

      time.timeZone = cfg.timezone;

      users.users.${cfg.username} = {
        createHome = true;
        extraGroups = ["rtkit" "wheel"];
        ignoreShellProgramCheck = true;
      };
    };
  };
}
