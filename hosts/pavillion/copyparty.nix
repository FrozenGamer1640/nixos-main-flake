{
  pkgs,
  ...
}:
{
  environment.systemPackages = [ pkgs.copyparty ];
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
      ed.passwordFile = "/run/keys/copyparty/ed_password";
      k.passwordFile = "/run/keys/copyparty/k_password";
    };

    groups = {
      g1 = [
        "ed"
        "k"
      ];
    };

    volumes = {
      "/" = {
        path = "/srv/copyparty";
        # see `copyparty --help-accounts` for available options
        access = {
          r = "*";
          rw = [
            "ed"
            "k"
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
