_: {
  flake.nixosModules.binds = {
    lib,
    pkgs,
    ...
  }: {
    options.rainy.settings.binds = let
      modType = lib.types.enum ["super" "shift" "ctrl" "alt"];

      actionType = lib.types.submodule {
        freeformType = lib.types.attrsOf lib.types.anything;
        options.type = lib.mkOption {
          type = lib.types.str;
          example = "window.close";
        };
      };
    in {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          mods = lib.mkOption {
            type = lib.types.listOf modType;
            default = [];
          };
          key = lib.mkOption {
            type = lib.types.str;
          };
          flags = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
          };
          action = lib.mkOption {
            type = actionType;
          };
        };
      });
    };

    config.rainy.settings.binds = let
      workspaceBinds = lib.listToAttrs (lib.concatMap
        (i: let
          key = toString (lib.mod i 10);
        in [
          {
            name = "workspace-${toString i}";
            value = {
              mods = ["super"];
              inherit key;
              action = {
                type = "workspace";
                index = i;
              };
            };
          }
          {
            name = "move-to-workspace-${toString i}";
            value = {
              mods = ["super" "shift"];
              inherit key;
              action = {
                type = "moveToWorkspace";
                index = i;
              };
            };
          }
        ])
        (lib.range 1 10));
    in
      lib.mkDefault (workspaceBinds
        // {
          launch-terminal = {
            mods = ["super"];
            key = "I";
            action = {
              type = "cmd";
              command = "handlr launch x-scheme-handler/terminal";
            };
          };
          launch-browser = {
            mods = ["super"];
            key = "B";
            action = {
              type = "cmd";
              command = "handlr launch x-scheme-handler/http*";
            };
          };

          window-close = {
            mods = ["super"];
            key = "Q";
            action = {type = "windowClose";};
          };
          window-fullscreen = {
            mods = [];
            key = "F11";
            action = {
              type = "windowFullscreen";
              mode = "fullscreen";
            };
          };
          window-maximize = {
            mods = ["shift"];
            key = "F11";
            action = {
              type = "windowFullscreen";
              mode = "maximize";
            };
          };
          window-float-toggle = {
            mods = ["super" "shift"];
            key = "T";
            action = {
              type = "windowFloat";
              state = "toggle";
            };
          };

          window-drag = {
            mods = ["super"];
            key = "mouse_left";
            flags = ["mouse"];
            action = {type = "windowDrag";};
          };
          window-resize = {
            mods = ["super"];
            key = "mouse_right";
            flags = ["mouse"];
            action = {type = "windowResize";};
          };

          focus-left = {
            mods = ["super"];
            key = "H";
            action = {
              type = "focus";
              direction = "left";
            };
          };
          focus-down = {
            mods = ["super"];
            key = "J";
            action = {
              type = "focus";
              direction = "down";
            };
          };
          focus-up = {
            mods = ["super"];
            key = "K";
            action = {
              type = "focus";
              direction = "up";
            };
          };
          focus-right = {
            mods = ["super"];
            key = "L";
            action = {
              type = "focus";
              direction = "right";
            };
          };

          workspace-next = {
            mods = ["super"];
            key = "mouse_scroll_down";
            action = {
              type = "workspaceRelative";
              direction = "next";
            };
          };
          workspace-prev = {
            mods = ["super"];
            key = "mouse_scroll_up";
            action = {
              type = "workspaceRelative";
              direction = "prev";
            };
          };

          brightness-down = {
            mods = [];
            key = "F4";
            action = {
              type = "cmd";
              command = "${lib.getExe pkgs.brightnessctl} set 5%-";
            };
          };
          brightness-up = {
            mods = [];
            key = "F5";
            action = {
              type = "cmd";
              command = "${lib.getExe pkgs.brightnessctl} set 5%+";
            };
          };
        });
  };
}
