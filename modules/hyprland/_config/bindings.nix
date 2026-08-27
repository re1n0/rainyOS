{
  lib,
  osConfig,
  ...
}: {
  bind = let
    cfg = osConfig.rainy.settings.bindings.tiling;
    mkLua = lib.generators.mkLuaInline;
    luaStr = builtins.toJSON;

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

    luaFlagsTable = flags: "{ ${lib.concatStringsSep ", " (map (f: "${f} = true") flags)} }";

    dispatch = {
      cmd = a: "exec_cmd(${luaStr a.command})";
      windowClose = _: "window.close()";
      windowFullscreen = a: let
        modes = {
          fullscreen = "1";
          maximize = "0";
        };
      in "window.fullscreen({ mode = ${modes.${a.mode}} })";
      windowFloat = a: "window.float({ action = ${luaStr a.state} })";
      focus = a: "focus({ direction = ${luaStr a.direction} })";
      workspace = a: "focus({ workspace = ${toString a.index} })";
      moveToWorkspace = a: "window.move({ workspace = ${toString a.index} })";
      workspaceRelative = a: let
        rel = {
          next = "e+1";
          prev = "e-1";
        };
      in "focus({ workspace = ${luaStr rel.${a.direction}} })";
      windowDrag = _: "window.drag()";
      windowResize = _: "window.resize()";
    };

    renderDispatcher = name: action: let
      fn =
        dispatch.${
          action.type
        }
        or (throw ''
          rainy: bind "${name}" uses action type "${action.type}", which the
          Hyprland layer doesn't know how to render. Add a case for it to
          `dispatch` helper.
        '');
    in "hl.dsp.${fn action}";

    activeBinds = lib.filterAttrs (_: v: v != null) cfg;

    bindsData =
      lib.mapAttrsToList
      (name: bind: {
        combo = hyprCombo bind;
        flags = checkFlags name bind.flags;
        dispatcher = renderDispatcher name bind.action;
      })
      activeBinds;
  in
    map (b: {
      _args =
        [b.combo (mkLua b.dispatcher)]
        ++ lib.optional (b.flags != []) (mkLua (luaFlagsTable b.flags));
    })
    bindsData;
}
