{
  lib,
  ...
}:
let
  vimDirectionsKeys = [
    "h"
    "j"
    "k"
    "l"
  ];
  vimDirections = [
    "l"
    "d"
    "u"
    "r"
  ];
in
{
  wayland.windowManager.hyprland.settings = {
    bind = lib.concatLists [
      (lib.forEach [
        "Return, exec, $terminal"
        "C, killactive,"
        "E, exec, $terminal yazi"
        "V, togglefloating,"
        "R, exec, wofi --show drun"
        "N, togglesplit," # dwindle layout only
        "Q, exec, hyprlock"
      ] (x: "SUPER, ${x}"))

      (lib.forEach [
        "P, pin"
        "F, fullscreen"
        "M, fullscreen, 1"

        "S, submap, Screenshot"
      ] (x: "SUPER SHIFT, ${x}"))

      (lib.forEach [
        "M, exit"
      ] (x: "SUPER ALT, ${x}"))

      (lib.zipListsWith (a: b: "SUPER, ${a}, movefocus, ${b}") vimDirectionsKeys vimDirections)

      (lib.zipListsWith (a: b: "SUPER SHIFT, ${a}, movewindow, ${b}") vimDirectionsKeys vimDirections)

      (lib.zipListsWith (a: b: "SUPER CTRL, ${a}, resizeactive, ${b}") vimDirectionsKeys [
        "-20 0"
        "0 20"
        "0 -20"
        "20 0"
      ])

      (lib.genList (i: "SUPER, ${toString (i + 1)}, workspace, ${toString (i + 1)}") 9)

      (lib.genList (i: "SUPER SHIFT, ${toString (i + 1)}, movetoworkspace, ${toString (i + 1)}") 9)

      (lib.zipListsWith (a: b: "SUPER ALT, ${toString (a + 1)}, togglespecialworkspace, ${b}")
        (lib.genList (x: x) 2)
        [
          "social"
          "quickAccess"
        ]
      )

      (lib.zipListsWith (a: b: "SUPER SHIFT&ALT, ${toString (a + 1)}, movetoworkspace, special:${b}")
        (lib.genList (x: x) 2)
        [
          "social"
          "quickAccess"
        ]
      )
    ];

    bindm = lib.concatLists [
      (lib.forEach [
        "2, movewindow"
        "3, resizewindow"
      ] (x: "SUPER, mouse:27${x}"))
    ];

    bindel = lib.concatLists [
      (lib.zipListsWith (a: b: ",XF86Audio${a}Volume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%${b}")
        [
          "Raise"
          "Lower"
        ]
        [
          "+"
          "-"
        ]
      )

      (lib.zipListsWith (a: b: ",XF86Audio${a}Mute, exec, wpctl set-mute @DEFAULT_AUDIO_${b}@ toggle")
        [
          ""
          "Mic"
        ]
        [
          "SINK"
          "SOURCE"
        ]
      )

      (lib.zipListsWith (a: b: ",XF86MonBrightness${a}, exec, brightnessctl s 5%${b}")
        [
          "Up"
          "Down"
        ]
        [
          "+"
          "-"
        ]
      )
    ];

    bindl = lib.concatLists [
      (lib.zipListsWith (a: b: ",XF86Audio${a}, exec, playerctl ${b}")
        [
          "Next"
          "Pause"
          "Play"
          "Prev"
        ]
        [
          "next"
          "play-pause"
          "play-pause"
          "previous"
        ]
      )
    ];
  };
}
