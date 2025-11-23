{ pkgs, fuyuHomeModules, fuyuGenericModules, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = with fuyuHomeModules; [
    fuyuGenericModules.stylix
    git xdg gpg dunst zsh
    eww hyprland
    obs-studio
    vesktop
    zed-editor
    fuyu-games
  ];

  home = {
    stateVersion = "25.05";
    username = "frozenfox";
    homeDirectory = "/home/frozenfox";
  };

  wayland.windowManager.hyprland.package = inputs.hyprland.packages.${pkgs.system}.default;

  programs = {
    cava.enable = true;
    jq.enable = true;
  };

  home.packages = with pkgs; [
    google-chrome youtube-music
    anki-bin
    wl-clicker
  ];

  stylix.targets = {
    gtk.enable = true;
    qt.enable = true;
    kitty.enable = true;
    starship.enable = true;
  };
}
