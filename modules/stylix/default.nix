{
  pkgs,
  config,
  ...
}:
let
  hackNerdFont = {
    package = pkgs.nerd-fonts.hack;
    name = "HackNerdFont";
  };
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    polarity = "dark";
    autoEnable = false;
    image = (config.lib.stylix.pixel "base01");
    fonts = {
      serif = hackNerdFont;
      sansSerif = hackNerdFont;
      monospace = hackNerdFont;
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "NotoFontsColorEmoji";
      };
    };
  };
}
