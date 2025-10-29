{ inputs, pkgs, ezModules, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ezModules.pipewire
  ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";

  users.users.frozenfox = {
    isNormalUser = true;
    extraGroups = [ "input" "wheel" "networkmanager" ];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 25;
    };
  };

  services = {
    upower.enable = true;
    gnome.gnome-keyring.enable = true;

    displayManager = {
      cosmic-greeter.enable = true;
    };
  };

  programs = {
    dconf.enable = true;
    xwayland.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      acpi tlp home-manager nixd libnotify nil killall
      ripgrep btop p7zip imagemagick lua
      playerctl pavucontrol helvum
      inotify-tools fastfetch
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    ];
    sessionVariables = {
      NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
      NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
      # XDG_DATA_HOME = "$HOME/.local/share";
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      EDITOR = "zeditor";
      NIXOS_OZONE_WL = "1";
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

  nix.settings.allowed-users = [ "frozenfox" ];

  time.timeZone = "America/Costa_Rica";
  i18n = {
    defaultLocale = "es_MX.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_CR.UTF-8";
      LC_IDENTIFICATION = "es_CR.UTF-8";
      LC_MEASUREMENT = "es_CR.UTF-8";
      LC_MONETARY = "es_CR.UTF-8";
      LC_NAME = "es_CR.UTF-8";
      LC_NUMERIC = "es_CR.UTF-8";
      LC_PAPER = "es_CR.UTF-8";
      LC_TELEPHONE = "es_CR.UTF-8";
      LC_TIME = "es_CR.UTF-8";
    };
  };

  console = {
    #font = "JetBrainsMono";
    keyMap = "la-latin1";
  };

  networking = {
    #wireless.iwd.enable = true;
    networkmanager.enable = true;
    hostName = "FrozenFox";
    firewall = {
      enable = true;
      #allowedTCPPorts = [ 443 80 ];
      #allowedUDPPorts = [ 443 80 44857 ];
      #allowPing = false;
    };
  };

  security.rtkit.enable = true;

  hardware = {
    bluetooth.enable = false;
    graphics.enable = true;
  };

  fileSystems."/mnt/Xtra" = {
    device = "/dev/disk/by-uuid/86384BEC384BD9B7";
    fsType = "ntfs";
    options = ["nofail"];
  };
}
