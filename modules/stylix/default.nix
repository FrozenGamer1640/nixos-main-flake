{ pkgs, lib, assets, config, ... }:
let
  customWallpaperPath = assets + /customWallpaper.webp;
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    polarity = "dark";
    autoEnable = false;
    image = if (lib.pathExists customWallpaperPath) then customWallpaperPath else (config.lib.stylix.pixel "base01");
  };
}
