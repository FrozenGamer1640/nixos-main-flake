{
  pkgs,
  ...
}:
{
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
        };
      };
    };
    dbus.enable = true;
    playerctld.enable = true;
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

  stylix.targets = {
    wofi.enable = true;
    vim.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    hyprlock.enable = true;
    dconf.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  environment.systemPackages = with pkgs; [
    ripgrep
    wl-clipboard
    wofi
    vieb
    vim
  ];
}
