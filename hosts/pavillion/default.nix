{ inputs, pkgs, ezModules, attrSetFromDir, localPkgsPath, ... }:
let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
  local-pkgs = attrSetFromDir {
    directory = localPkgsPath;
    inherit pkgs;
  };
in
{
  imports = with ezModules; [
    ./hardware-configuration.nix
    pipewire locale-es-cr fonts
  ];

  fuyuExtras = {
    unstable-pkgs = {
      inherit (unstable-pkgs) osu-lazer-bin;
      inherit (unstable-pkgs) zed-editor;
      inherit (unstable-pkgs) prismlauncher;
    };
    inherit local-pkgs;
  };

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
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      acpi tlp home-manager nixd libnotify nil killall
      ripgrep btop p7zip imagemagick lua
      playerctl pavucontrol helvum
      inotify-tools fastfetch
      unstable-pkgs.zed-editor
      inputs.hyprcursor-rose-pine.packages.${pkgs.system}.default
    ];
    sessionVariables = {
      NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
      NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
      NIXOS_OZONE_WL = "1";
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      EDITOR = "zeditor";
    };
  };

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
    device = "/dev/disk/by-uuid/86384BEC384BD9B7";
    fsType = "ntfs";
    options = ["nofail"];
  };
}
