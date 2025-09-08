{ inputs, pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    wofi swaybg wlsunset wl-clipboard hyprland kitty swww
    hyprpolkitagent wireplumber grimblast
  ];

  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
}