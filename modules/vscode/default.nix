{ pkgs, lib, config, ... }:

let
  staticSettings = builtins.fromJSON (builtins.readFile ./settings.json);

  dynamicSettings = {};
in

{
  programs.vscode = {
    enable = true;
  };

  #home.file.".config/Code/User/settings.json".text = pkgs.lib.generators.toJSON {} (staticSettings // dynamicSettings);
}
