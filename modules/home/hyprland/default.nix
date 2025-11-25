{ pkgs, config, lib, ... }:
let
  palette = config.lib.stylix.colors;
in
{
  stylix.targets = {
    hyprland.enable = true;
    hyprpaper.enable = true;
    hyprlock.enable = true;
  };

  services = {
    hyprpolkitagent.enable = true;
    hyprsunset.enable = true;
    hypridle.enable = true;
    hyprpaper.enable = true;
  };

  programs = {
    hyprlock.enable = true;
    kitty.enable = true;
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
    kitty
    wofi
    wl-clipboard grimblast
  ];

  home.sessionVariables = {
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE = "24";
    GDK_BACKEND = "wayland";
  };
}
