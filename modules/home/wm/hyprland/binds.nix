let
  launchMime =
    bind: mime:
    builtins.concatStringsSep " " [
      bind
      "handlr"
      "launch"
      mime
    ];
in
{
  "$super" = "SUPER";
  "$superMod" = "$super SHIFT";

  bind = [
    (launchMime "$super, I, exec," "x-scheme-handler/terminal")
    (launchMime "$super, B, exec," "x-scheme-handler/http*")

    "$super, Q, killactive"
    "$super, F, fullscreen, 1"
    "$superMod, F, fullscreen, 0"
    "$superMod, T, togglefloating"

    "$super, D, exec, ags toggle launcher"

    "$super, H, movefocus, l"
    "$super, J, movefocus, d"
    "$super, K, movefocus, u"
    "$super, L, movefocus, r"

    "$super, mouse_down, workspace, e+1"
    "$super, mouse_up, workspace, e-1"

    "$super, S, exec, screenshot --full"
    "$superMod, S, exec, screenshot --crop"

    "$super, F4, exec, brightnessctl set 5%-"
    "$super, F5, exec, brightnessctl set 5%+"
  ]
  ++ (builtins.concatLists (
    builtins.genList (
      x:
      let
        ws =
          let
            c = (x + 1) / 10;
          in
          toString (x + 1 - (c * 10));
      in
      [
        "$super, ${ws}, workspace, ${toString (x + 1)}"
        "$superMod, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    ) 10
  ));

  bindm = [ "$super, mouse:272, movewindow" ];
}
