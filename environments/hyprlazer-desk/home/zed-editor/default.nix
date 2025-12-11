{
  pkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
    mutableUserSettings = true;
    extraPackages = with pkgs; [
      discord-presence-lsp
    ];
    extensions = [
      "nix"
      "qml"
      "toml"
      "rust"
      "hyprlang"
      "gdscript"
      "discord-presence"
      "git-firefly"
      "github-actions"
    ];
  };
}
