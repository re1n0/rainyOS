let
  binds = import ./binds.nix;
in
settings:
{
  exec-once = [
    "hyprpolkitagent"
  ];

  input = {
    kb_layout = builtins.concatStringsSep "," settings.keymap.supported;
    kb_options = "grp:win_space_toggle";

    repeat_rate = 50;
    repeat_delay = 240;

    touchpad = {
      disable_while_typing = false;
      natural_scroll = true;
      clickfinger_behavior = true;
    };

    sensitivity = 0;
  };

  gestures.workspace_swipe_min_speed_to_force = 15;

  cursor = {
    sync_gsettings_theme = true;
    enable_hyprcursor = false;
    use_cpu_buffer = true;
  };

  monitorv2 = map
    (m: {
      output = m.connector;
      mode = "${builtins.toString m.width}x${builtins.toString m.height}@${builtins.toString m.refresh}";
      inherit (m) position;
      inherit (m) scale;
      supports_wide_color = m.wide_color;
      supports_hdr = m.hdr;
      bitdepth = if m.wide_color then 10 else 8;
    })
    settings.gui.monitors;

  general = {
    border_size = 3;

    gaps_in = 5;
    gaps_out = 7;

    layout = "dwindle";

    allow_tearing = true;

    resize_on_border = true;
  };

  dwindle = {
    pseudotile = true;
    preserve_split = true;
    force_split = false;
  };

  misc = {
    disable_hyprland_logo = 1;
    disable_splash_rendering = 1;
  };

  render = {
    direct_scanout = 2;
    cm_fs_passthrough = 1;
  };

  experimental = {
    xx_color_management_v4 = true;
  };

  decoration = {
    rounding = 0;

    blur.enabled = false;

    shadow.enabled = false;
  };

  animations = {
    enabled = true;

    bezier = [
      "wind, 0.22, 1, 0.36, 1"
      "winIn, 0.16, 1, 0.3, 1"
      "winOut, 0.33, 1, 0.68, 1"
    ];

    animation = [
      "windows, 1, 6, wind, slide"
      "windowsIn, 1, 6, winIn, slide"
      "windowsOut, 1, 5, winOut, slide"
      "windowsMove, 1, 5, wind, slide"
      "border, 1, 10, default"
      "fade, 1, 10, default"
      "workspaces, 1, 5, wind"
    ];
  };

  "plugin:dynamic-cursors" = {
    enabled = true;
    node = "tilt";
    threshold = 1;

    tilt = {
      limit = 5000;
      function = "negative_quadratic";
    };

    shake = {
      enabled = false;
      nearest = true;
      threshold = 5.0;
      base = 1.0;
      speed = 1.0;
      influance = 0.5;
      limit = 0.0;
      timeout = 1000;
      effects = true;
      ipc = false;
    };

    hyprcursor = {
      enabled = true;
      nearest = true;
      resolution = -1;
      fallback = "clientside";
    };
  };

  ecosystem = {
    no_update_news = true;
    no_donation_nag = true;
  };
}
  // binds
