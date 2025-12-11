{
  pkgs,
  ...
}:
{
  imports = [
    ./nextcloud.nix
    ./copyparty.nix
  ];

  system.stateVersion = "25.11";

  nix.settings.allowed-users = [ "frozenfox" ];
  users.users.frozenfox = {
    isNormalUser = true;
    extraGroups = [
      "input"
      "wheel"
      "networkmanager"
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      home-manager
      acpi
      tlp
      nixd
      libnotify
      nil
      btop
      p7zip
      imagemagick
      starship
      playerctl
      pavucontrol
      helvum
      inotify-tools
      fastfetch
      easyeffects
      zed-editor
      rose-pine-hyprcursor
      vesktop
    ];
    # sessionVariables = {
    # NIXOS_OZONE_WL = "1";
    # PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    # };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "Pavillion-Laptop";
    firewall.enable = true;
  };

  hardware = {
    bluetooth.enable = false;
    graphics.enable = true;
  };

  fileSystems."/mnt/Xtra" = {
    device = "/dev/disk/by-uuid/b43e0502-b5ed-4498-b491-c66fa78bddfe";
    fsType = "btrfs";
    options = [ "nofail" ];
  };
}
