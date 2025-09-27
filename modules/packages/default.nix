{ pkgs, lib, config, ... }:

with lib;
let
    screen = pkgs.writeShellScriptBin "screen" ''${builtins.readFile ./screen}'';
    bandw = pkgs.writeShellScriptBin "bandw" ''${builtins.readFile ./bandw}'';
    maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintenance}'';
in
{
  programs = {
    mpv.enable = true;
    ripgrep.enable = true;
    btop.enable = true;
    gpg.enable = true;
    fastfetch.enable = true;
    cava.enable = true;
    obs-studio.enable = true;
  };

  home.packages = with pkgs; [
    screen bandw maintenance
    wl-clicker
    pass age
    imagemagick libnotify
    lua inkscape
    anki-bin helvum

    playerctl p7zip
    google-chrome
    youtube-music vesktop
    osu-lazer-bin prismlauncher
    killall inotify-tools
  ];
}
