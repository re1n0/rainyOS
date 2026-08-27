{
  lib,
  osConfig,
  ...
}: let
  toLua = lib.generators.toLua {};
in {
  config = {
    cursor = {
      enable_hyprcursor = true;

      sync_gsettings_theme = true;
    };

    input = {
      kb_options = "grp:win_space_toggle";

      kb_layout = toLua osConfig.rainy.settings.keyboard.layout;

      repeat_rate = 50;
      repeat_delay = 240;

      sensitivity = 0;

      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;
        clickfinger_behavior = true;
      };
    };

    gestures.workspace_swipe_min_speed_to_force = 15;
  };
}
