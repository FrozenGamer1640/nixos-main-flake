{ config, pkgs, inputs, ... }:

{
  # Remove unecessary preinstalled packages
  #environment.defaultPackages = [ ];

  nixpkgs.config.allowUnfree = true;
  programs.dconf.enable = true;

  services = {
    displayManager.sddm.enable = true;
    xserver = {
      enable = true;
      desktopManager.gnome.enable = false;
    };
  };


  #programs.zsh.enable = true;

  # Laptop-specific packages (the other ones are installed in `packages.nix`)
  environment.systemPackages = with pkgs; [
    acpi tlp home-manager
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];

  # Install fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
      jetbrains-mono
      openmoji-color
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.noto
      libre-caslon
      babelstone-han
      symbola
    ];

    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans" "Hack Nerd Font" ];
        serif = [ "Libre Caslon Text" ];
        monospace = [ "Hack Nerd Font Mono" ];
        emoji = [ "OpenMoji Color" ];
      };
    };
  };


  # Wayland stuff: enable XDG integration, allow sway to use brillo
  xdg.portal.config = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    # gtkUsePortal = true;
  };

  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "frozenfox" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Boot settings: clean /tmp/, latest kernel and enable bootloader
  boot = {
    # cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 20;
    };
  };

  # Set up locales (timezone and keyboard layout)
  time.timeZone = "America/Costa_Rica";
  i18n.defaultLocale = "es_MX.UTF-8";

  i18n.extraLocaleSettings = {
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

  console = {
    #font = "JetBrainsMono";
    keyMap = "la-latin1";
  };

  # Set up user and enable sudo
  users.users.frozenfox = {
    isNormalUser = true;
    extraGroups = [ "input" "wheel" "networkmanager" ];
    # shell = pkgs.zsh;
  };

  # Set up networking and secure it
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

  # Set environment variables
  environment.sessionVariables = {
    NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
    GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
    MOZ_ENABLE_WAYLAND = "1";
    ZK_NOTEBOOK_DIR = "$HOME/stuff/notes/";
    EDITOR = "vscode";
    DIRENV_LOG_FORMAT = "";
    ANKI_WAYLAND = "1";
    DISABLE_QT5_COMPAT = "0";

	  NIXOS_OZONE_WL = "1";
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Disable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
    bluetooth.enable = false;
    graphics = {
      enable = true;
      # driSupport = true;
    };
  };

  fileSystems."/mnt/Xtra" = {
    device = "/dev/disk/by-uuid/86384BEC384BD9B7";
    fsType = "ntfs";
    options = ["nofail"];
  };

  # Do not touch
  system.stateVersion = "25.05";
}
