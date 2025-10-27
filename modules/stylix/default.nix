{ pkgs, ... }:
{
  stylix = {
      enable = true;
      opacity = 0.95;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
      polarity = "dark";
    };
}
