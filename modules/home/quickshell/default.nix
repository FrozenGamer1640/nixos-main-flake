{
  ...
}:
{
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
    configs."shell.qml" = ./shell.qml;
  };
}
