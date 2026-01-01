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
      zed-discord-presence
      zed-color-highlight
      nixd
      nil
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
