_: {
  config = {
    general = {
      gaps_in = 5;
      gaps_out = 10;

      border_size = 3;

      allow_tearing = true;
      resize_on_border = false;

      layout = "dwindle";
    };

    decorations = {
      rounding = 0;

      blur.enabled = false;

      shadow.enabled = false;
    };

    dwindle = {
      preserve_split = true;
      force_split = 2;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      disable_scale_notification = true;
      focus_on_activate = true;
      anr_missed_pings = 3;
      on_focus_under_fullscreen = 1;
      allow_session_lock_restore = true;
    };

    animations.enabled = true;

    ecosystem = {
      no_donation_nag = true;
      no_update_news = true;
    };
  };
}
