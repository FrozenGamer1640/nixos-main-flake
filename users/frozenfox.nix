{ pkgs, fuyuHomeModules, fuyuGenericModules, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = with fuyuHomeModules; [
    fuyuGenericModules.stylix
    git xdg gpg dunst zsh
    eww hyprland
    kitty
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
    kitty.enable = true;
    vim.enable = true;
    mpv.enable = true;
    zsh.sessionVariables = { NIXPKGS_ALLOW_UNFREE = "1"; };
  };

  programs.thunderbird = {
    enable = true;
    profiles.Fuyuka = {
      isDefault = true;
    };
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
    wofi.enable = true;
    vim.enable = true;
    btop.enable = true;
    mpv.enable = true;
  };
}
