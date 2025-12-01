{ pkgs, config, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostName = "localhost";
    home = "/mnt/Xtra/@SQLite"; # Yes, I use btrfs lmao
    https = true;
    extraAppsEnable = true;
    settings.overwriteprotocol = "https";
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      dbtype = "sqlite";
    };
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks;
    };
  };

  services.netbird = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    netbird-dashboard
  ];
}
