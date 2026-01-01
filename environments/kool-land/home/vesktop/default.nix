{
  config,
  ...
}:
let
  palette = config.lib.stylix.colors;
in
{
  programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "stable";
      minimizeToTray = false;
      tray = false;
      splashTheming = true;
      splashBackground = "#${palette.base00}";
      splashColor = "#${palette.base04}";
    };
  };

  programs.vesktop.vencord = {
    useSystem = true;
    settings = {
      autoUpdate = false;
      autoUpdateNotification = false;
      notifyAboutUpdates = false;
      disableMinSize = true;
      plugins = {
        MessageLogger.enabled = true;
        FakeNitro.enabled = true;
      };
    };
  };
}
