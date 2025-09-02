{ inputs, pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    wofi swaybg wlsunset wl-clipboard hyprland kitty swww
    hyprpolkitagent wireplumber
  ];

  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
}