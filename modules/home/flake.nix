lib:
{
  default = {
    home.stateVersion = "25.11";
  };
}
// (lib.genAttrs [
  "dunst"
  "git"
  "zsh"
  "osu-resources"
  "xdg"
  "zed-editor"
  "hyprsunset"
] (moduleName: ./${moduleName}));

