{
  pkgs,
  config,
  lib,
  ...
}:
let
  palette = config.lib.stylix.colors;
in
{
  services = {
    hypridle.enable = true;
    hyprpaper.enable = true;
    hyprpolkitagent.enable = true;
  };

  programs = {
    hyprshot.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    submaps = {
      "Screenshot".settings = {
        bind = [
          ", PRINT, exec, hyprshot -m region -z --clipboard-only ; hyprctl dispatch submap reset"
          ", escape, submap, reset"
        ];
      };
    };
    settings = {
      general = lib.mkForce {
        "col.inactive_border" = "rgb(${palette.base00})";
        "col.active_border" = "rgb(${palette.base04})";
      };
    };
  };

  home.packages = with pkgs; [
    wofi
    wl-clipboard
  ];
}
