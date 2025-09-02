{ pkgs, lib, config, ... }:

{
  programs.vscode = {
    enable = true;
  };

  home.file.".config/Code/User/settings.json".source = ./settings.json;
}