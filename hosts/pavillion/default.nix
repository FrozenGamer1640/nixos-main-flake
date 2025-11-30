{ inputs', pkgs, unstable-pkgs, fuyuNixosModules, ... }:
{
  imports = with fuyuNixosModules; [
    ./hardware-configuration.nix
    fonts locale-es-cr
    pipewire
    steam
    vieb-nix
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";

  nix.settings.allowed-users = [ "frozenfox" ];
  users.users.frozenfox = {
    isNormalUser = true;
    extraGroups = [ "input" "wheel" "networkmanager" ];
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
    hyprland = {
      enable = true;
      package = inputs'.hyprland.packages.default;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      acpi tlp home-manager nixd libnotify nil killall
      ripgrep btop p7zip imagemagick lua starship
      playerctl pavucontrol helvum
      inotify-tools fastfetch
      unstable-pkgs.zed-editor
      inputs'.hyprcursor-rose-pine.packages.default
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
    options = ["nofail"];
  };
}
