{
  config,
  lib,
  ...
}:
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  }
  // lib.genAttrs [
    "documents"
    "download"
    "videos"
    "music"
    "pictures"
    "desktop"
    "publicShare"
    "templates"
  ] (dir: "${config.home.homeDirectory}/${lib.toSentenceCase dir}");
}
