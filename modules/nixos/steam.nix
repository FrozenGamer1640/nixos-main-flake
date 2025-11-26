{ ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
    protontricks.enable = true;
    gamescopeSession = {
      enable = true;
    };
  };
}
