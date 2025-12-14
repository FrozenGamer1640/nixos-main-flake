{
  pkgs,
  ...
}:
{
  environment.systemPackages = [ pkgs.copyparty ];
  services.netbird.enable = true;
  services.copyparty = {
    enable = true;
    user = "copyparty";
    group = "copyparty";

    # see `copyparty --help` for available options
    # settings = {
    #   i = "0.0.0.0";
    #   p = [
    #     3210
    #     3211
    #   ];
    #   no-reload = true;
    #   ignored-flag = false;
    # };

    accounts = {
      frozenfox.passwordFile = "/mnt/keys/copyparty/frozenfox_password";
    };

    groups = {
      root = [
        "frozenfox"
      ];
    };

    volumes = {
      "/" = {
        path = "/srv/copyparty";
        # see `copyparty --help-accounts` for available options
        access = {
          r = "*";
          rw = [
            "frozenfox"
          ];
        };
        # see `copyparty --help-flags` for available options
        flags = {
          fk = 4;
          scan = 60;
          e2d = true;
          nohash = "\.iso$";
        };
      };
    };
    openFilesLimit = 8192;
  };
}
