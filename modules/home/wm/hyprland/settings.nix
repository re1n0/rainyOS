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

  monitorv2 = map (m: {
    output = m.connector;

    mode = "${toString m.width}x${toString m.height}@${toString m.refresh}";

    inherit (m) position scale;

    supports_wide_color = if m.wide_color then 1 else -1;
    supports_hdr = if m.hdr then 1 else -1;

    bitdepth = if m.wide_color then 10 else 8;
    cm = if m.hdr then "hdr" else "auto";

    sdrsaturation = if m.hdr then 1.2 else 1.0;

    sdr_max_luminance = if m.hdr then 200 else null;
    sdr_min_luminance = if m.hdr then 0.005 else null;

    sdr_eotf = "srgb";

    # icc = m.icc
  }) settings.gui.monitors;

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
    cm_auto_hdr = 0;
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
