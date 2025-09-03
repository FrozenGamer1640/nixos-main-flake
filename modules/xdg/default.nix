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

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}