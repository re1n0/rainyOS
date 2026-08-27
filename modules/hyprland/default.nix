{mkTarget, ...}:
mkTarget "hyprland" {
  tags = ["gui" "hyprland"];
  description = "Hyprland tiling window manager";

  nixos = _: {
    programs.hyprland.enable = true;
  };

  hm = {
    lib,
    osConfig,
    pkgs,
    ...
  }: let
    toLua = lib.generators.toLua {};
  in {
    systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];

    services.hyprpolkitagent.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };

      configType = "lua";

      extraLuaFiles = {
        "00-default" = ./default.lua;
        "01-keymap" = pkgs.writeText "hyprland-keymap.lua" ''
          hl.config({
            input = {
              kb_layout = ${toLua osConfig.rainy.settings.keyboard.layout},
            },
          })
        '';
        "02-monitors" = let
          monitorData =
            map (d: {
              inherit (d) connector position scale hdr wide_color cm eotf icc;
              mode = "${d.resolution}@${toString d.refresh}";
            })
            osConfig.rainy.settings.displays;
        in
          pkgs.writeText "hyprland-monitors.lua" ''
            for _, m in ipairs(${toLua monitorData}) do
              hl.monitor({
                output = m.connector,
                mode = m.mode,
                position = m.position,
                scale = m.scale,
                supports_wide_color = m.wide_color and 1 or -1,
                supports_hdr = m.hdr and 1 or -1,
                cm = m.cm or m.hdr and "hdr" or "srgb",
                sdrsaturation = m.hdr and 1.2 or 1.0,
                sdrbrightness = m.hdr and 1.2 or 1.0,
                sdr_min_luminance = m.hdr and 0.005 or nil,
                sdr_max_luminance = m.hdr and 225 or nil,
                sdr_eotf = m.eotf,
              })
            end
          '';
        "03-binds-function" = ./bindings.lua;
        "04-binds" = let
          cfg = osConfig.rainy.settings.binds;

          modNames = {
            super = "SUPER";
            shift = "SHIFT";
            ctrl = "CTRL";
            alt = "ALT";
          };

          specialKeyNames = {
            mouse_left = "mouse:272";
            mouse_right = "mouse:273";
            mouse_middle = "mouse:274";
            mouse_scroll_up = "mouse_up";
            mouse_scroll_down = "mouse_down";
          };

          hyprKey = key: specialKeyNames.${key} or key;

          hyprCombo = bind: let
            mods = lib.concatStringsSep " + " (map (m: modNames.${m}) bind.mods);
            key = hyprKey bind.key;
          in
            if mods == ""
            then key
            else "${mods} + ${key}";

          knownFlags = [
            "locked"
            "release"
            "click"
            "drag"
            "long_press"
            "repeating"
            "non_consuming"
            "auto_consuming"
            "mouse"
          ];

          checkFlags = name: flags: let
            unknown = lib.filter (f: !(lib.elem f knownFlags)) flags;
          in
            if unknown == []
            then flags
            else
              throw ''
                rainy: bind "${name}" uses unknown Hyprland flag(s):
                ${lib.concatStringsSep ", " unknown}
                Known flags: ${lib.concatStringsSep ", " knownFlags}
              '';

          activeBinds = lib.filterAttrs (_: v: v != null) cfg;

          bindsData =
            lib.mapAttrsToList
            (name: bind: {
              inherit name;
              combo = hyprCombo bind;
              flags = checkFlags name bind.flags;
              inherit (bind) action;
            })
            activeBinds;
        in
          pkgs.writeText "hyprland-binds.lua" ''
            for _, b in ipairs(${toLua bindsData}) do
              local fn = dispatch[b.action.type]
              if not fn then
                error("rainy: no Hyprland dispatcher for action type '"
                  .. b.action.type .. "' (bind '" .. b.name .. "')")
              end
              if #b.flags > 0 then
                hl.bind(b.combo, fn(b.action), toFlagsTable(b.flags))
              else
                hl.bind(b.combo, fn(b.action))
              end
            end
          '';
      };
    };
  };
}
