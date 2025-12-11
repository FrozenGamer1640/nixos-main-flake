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
  stylix.targets = {
    hyprland.enable = true;
    hyprpaper.enable = true;
    hyprlock.enable = true;
    yazi.enable = true;
  };

  services = {
    hypridle.enable = true;
    hyprpaper.enable = true;
    hyprpolkitagent.enable = true;
  };

  programs = {
    hyprshot.enable = true;
    yazi.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    systemd.enable = true;
    xwayland.enable = true;
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
