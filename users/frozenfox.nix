{
  inputs,
  pkgs,
  ...
}:
{
  # nixpkgs.config.allowUnfree = true;

  modules.home.services.seanime.enable = true;

  home = {
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
    # zsh.sessionVariables = {
    #   NIXPKGS_ALLOW_UNFREE = "1";
    # };
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
    osu-osu-lazer-bin
    prismlauncher
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
