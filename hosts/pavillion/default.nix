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

  services = {
    upower.enable = true;
    dbus.enable = true;
    playerctld.enable = true;
    hypridle.enable = true;
    gnome.gnome-keyring.enable = true;
    displayManager.ly = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    config.common.default = [ "hyprland" ];
    extraPortals = with pkgs; [
      xdg-desktop-portal-cosmic
    ];
    configPackages = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  programs = {
    dconf.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
    localsend = {
      enable = true;
      openFirewall = true;
    };
    hyprland = {
      enable = true;
      # package = inputs.hyprland.${pkgs.stdenv.system}.packages.default;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      home-manager
      acpi
      tlp
      nixd
      libnotify
      nil
      killall
      ripgrep
      btop
      p7zip
      imagemagick
      lua
      starship
      playerctl
      pavucontrol
      helvum
      inotify-tools
      fastfetch
      easyeffects
      zed-editor
      rose-pine-hyprcursor
      vieb
    ];
    sessionVariables = {
      NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
      NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
      NIXOS_OZONE_WL = "1";
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      EDITOR = "zeditor";
    };
  };

  users.defaultUserShell = pkgs.zsh;

  networking = {
    networkmanager.enable = true;
    hostName = "Pavillion-Laptop";
    firewall.enable = true;
  };

  security.rtkit.enable = true;

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
