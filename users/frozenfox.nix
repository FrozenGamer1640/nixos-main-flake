{
  pkgs,
  fuyuHomeModules,
  fuyuGenericModules,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  imports = with fuyuHomeModules; [
    fuyuGenericModules.stylix
    git
    xdg
    gpg
    dunst
    zsh
    eww
    hyprland
    kitty
    obs-studio
    vesktop
    zed-editor
    fuyu-games
    osu-resources
    inputs.seanime.nixosModules.seanime # WHY DOES THE FORMATTER WORK UNTIL NOW
  ];

  modules.home.services.seanime.enable = true;

  home = {
    stateVersion = "25.11";
    username = "frozenfox";
    homeDirectory = "/home/frozenfox";
  };

  wayland.windowManager.hyprland.package =
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;

  programs = {
    cava.enable = true;
    jq.enable = true;
    kitty.enable = true;
    vim.enable = true;
    mpv.enable = true;
    zsh.sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };
    osu-resources.enable = true; # Part of a local module
  };

  programs.thunderbird = {
    enable = true;
    profiles.Fuyuka = {
      isDefault = true;
    };
  };

  home.packages = with pkgs; [
    youtube-music
    anki-bin
    wl-clicker
    lutris
    winetricks
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
