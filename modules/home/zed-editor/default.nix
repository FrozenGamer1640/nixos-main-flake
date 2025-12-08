{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    discord-presence-lsp
    zed-editor
  ];

  stylix.targets.zed.enable = true;
}
