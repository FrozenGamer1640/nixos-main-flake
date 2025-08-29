{ pkgs, lib, config, ... }:

#with lib;
#let cfg = config.modules.vscode;

#in
{
    #options.modules.vscode = { enable = mkEnableOption "vscode"; };
    #config = mkIf cfg.enable {
      programs.vscode = {
        enable = true;
        profiles.default.extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          jnoortheen.nix-ide
          shardulm94.trailing-spaces
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
        ];
      };

      home.file.".config/Code/User/settings.json".source = ./settings.json;
    #};
}