{ inputs, pkgs, lib, config, ... }:

{
  services = {
    hyprpolkitagent.enable = true;
    hyprsunset.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {}; # It's empty for now
    extraConfig = builtins.readFile ./hyprland.conf;
    systemd.enable = true;
    xwayland.enable = true;
  };

  home.packages = with pkgs; [
    # --- Core ---
    kitty

    # --- UI & Theming ---
    wofi swww

    # --- Utilities ---
    wl-clipboard grimblast blueman
  ];

  #home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;

  home.sessionVariables = {
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE = "24";
    GDK_BACKEND = "wayland";
  };
}