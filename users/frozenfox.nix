{ ezModules, pkgs, unstable-pkgs, ... }:
{
  imports = with ezModules; [
    xdg gpg
    dunst
    git
    hyprland eww
    vesktop
    zed-editor
  ];

  home = {
    stateVersion = "25.05";
    username = "frozenfox";
    homeDirectory = "/home/frozenfox";
  };

  programs = {
    cava.enable = true;
    jq.enable = true;
  };

  home.packages = with pkgs; [
    inkscape libresprite pixelorama
    google-chrome youtube-music
    unstable-pkgs.osu-lazer-bin
    unstable-pkgs.prismlauncher
    anki-bin
    wl-clicker
  ];
}
