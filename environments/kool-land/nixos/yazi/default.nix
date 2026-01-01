{
  pkgs,
  ...
}:
{
  programs.yazi = {
    enable = true;
    plugins = {
      inherit (pkgs.yaziPlugins) wl-clipboard sudo starship;
    };
  };
}
