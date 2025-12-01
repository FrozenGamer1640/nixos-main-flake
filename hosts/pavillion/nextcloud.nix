{ pkgs, config, ... }:
{
  services.nextcloud = {
    enable = true;
    configureRedis = true;
    package = pkgs.nextcloud32;
    hostName = "pavillion-laptop.netbird.cloud"; # This is only accessible from my netbird acc
    home = "/mnt/Xtra/@SQLite"; # Yes, I use btrfs lmao
    https = false;
    extraAppsEnable = true;
    # settings.overwriteprotocol = "https";
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
