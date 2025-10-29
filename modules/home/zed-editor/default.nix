{ pkgs, ... }:
{
  home.packages = [
    pkgs.local.discord-presence-lsp
    pkgs.unstable.zed-editor
  ];
}
