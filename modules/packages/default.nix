{ pkgs, lib, config, ... }:

with lib;
let #cfg = config.modules.packages;
    screen = pkgs.writeShellScriptBin "screen" ''${builtins.readFile ./screen}'';
    bandw = pkgs.writeShellScriptBin "bandw" ''${builtins.readFile ./bandw}'';
    maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintenance}'';

in
{
    #options.modules.packages = { enable = mkEnableOption "packages"; };
    #config = mkIf cfg.enable {
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

            playerctl fastfetch
            google-chrome
            vesktop youtube-music
            inkscape osu-lazer-bin
            helvum killall
        ];
    #};
}
