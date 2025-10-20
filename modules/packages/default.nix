{ pkgs, lib, unstable-pkgs, ... }:

with lib;
let
    screen = pkgs.writeShellScriptBin "screen" ''${builtins.readFile ./screen}'';
    bandw = pkgs.writeShellScriptBin "bandw" ''${builtins.readFile ./bandw}'';
    maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintenance}'';
    discord-presence-lsp = import ./discord-presence-lsp.nix { inherit pkgs; };
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
    jq.enable = true;
  };

  home.packages = with pkgs; [
    screen bandw maintenance
    wl-clicker
    imagemagick libnotify
    lua inkscape
    anki-bin helvum
    discord-presence-lsp

    unstable-pkgs.zed-editor
    cosmic-files
    playerctl p7zip
    google-chrome
    youtube-music vesktop
    osu-lazer-bin prismlauncher
    killall inotify-tools discord-rpc
  ];
}
