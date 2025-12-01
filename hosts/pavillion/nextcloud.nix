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
    settings =
      let
        prot = "http"; # or https
        host = config.services.nextcloud.hostName;
        dir = "/nextcloud";
      in
      {
        overwriteprotocol = prot;
        overwritehost = host;
        overwritewebroot = dir;
        overwrite.cli.url = "${prot}://${host}${dir}/";
        htaccess.RewriteBase = dir;
      };
  };

  services.netbird = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    netbird-dashboard
  ];
}
