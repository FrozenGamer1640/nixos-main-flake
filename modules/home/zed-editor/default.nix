{ local-pkgs, unstable-pkgs, ... }:
{
  home.packages = [
    local-pkgs.discord-presence-lsp
    unstable-pkgs.zed-editor
  ];
}
