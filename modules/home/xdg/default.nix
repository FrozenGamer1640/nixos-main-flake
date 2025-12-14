{
  config,
  lib,
  ...
}:
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    download = "${config.home.homeDirectory}/stuff/Downloads";
  }
  // lib.genAttrs [
    "documents"
    "videos"
    "music"
    "pictures"
    "desktop"
    "publicShare"
    "templates"
  ] (dir: "${config.home.homeDirectory}/stuff/${lib.toSentenceCase dir}");
}
