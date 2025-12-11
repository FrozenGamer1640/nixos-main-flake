{
  imports = [
    ./hyprland
    ./quickshell
    ./kitty
    ./vesktop
    ./zed-editor
  ];

  services = {
    easyeffects.enable = true;
  };

  programs = {
    btop.enable = true;
    fastfetch.enable = true;
    osu-resources.enable = true; # Part of a local module
  };
}
