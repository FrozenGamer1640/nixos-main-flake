{ osConfig, ... }:
let
  unstable-pkgs = osConfig.fuyuExtras.unstable-pkgs;
  local-pkgs = osConfig.fuyuExtras.local-pkgs;
in
{
  home.packages = [
    local-pkgs.discord-presence-lsp
    unstable-pkgs.zed-editor
  ];
}
