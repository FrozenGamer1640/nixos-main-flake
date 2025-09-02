{ pkgs, lib, config, ... }:

{
  xdg.userDirs = {
    enable = true;
    documents = "$HOME/stuff/Documents/";
    download = "$HOME/stuff/Downloads/";
    videos = "$HOME/stuff/Videos/";
    music = "$HOME/stuff/Music/";
    pictures = "$HOME/stuff/Images/";
    desktop = "$HOME/stuff/Desktop/";
    publicShare = "$HOME/stuff/other/";
    templates = "$HOME/stuff/other/";
  };
}