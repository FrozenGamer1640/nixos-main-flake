{ pkgs, lib, config, ... }:

with lib;
let
    screen = pkgs.writeShellScriptBin "screen" ''${builtins.readFile ./screen}'';
    bandw = pkgs.writeShellScriptBin "bandw" ''${builtins.readFile ./bandw}'';
    maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintenance}'';
in
{
  home.packages = with pkgs; [
    ripgrep ffmpeg tealdeer
    # exa
    btop fzf
    pass gnupg bat
    unzip lowdown zk
    grim slurp slop
    imagemagick age libnotify
    git lua zig
    mpv pqiv
    screen bandw maintenance
    wf-recorder anki-bin

    playerctl fastfetch cava
    google-chrome
    vesktop youtube-music
    inkscape osu-lazer-bin
    helvum killall
  ];
}
