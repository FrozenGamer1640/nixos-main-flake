{
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland
    ./quickshell
    ./kitty
    ./vesktop
    ./zed-editor
    # ./neovim
  ];

  services = {
    easyeffects.enable = true;
    hypridle.settings = {
      general = {
        lock_cmd = "hyprlock";
      };
    };
  };

  programs = {
    btop.enable = true;
    fastfetch.enable = true;
    osu-resources.enable = true; # Part of a local module
  };
}
