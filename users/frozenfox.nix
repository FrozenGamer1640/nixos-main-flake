{ ezModules, stylix, ... }:
{
  imports = [
    stylix.home stylix.config
    ezModules.eww
  ];

  home = {
    stateVersion = "25.05";
    username = "frozenfox";
    homeDirectory = "/home/frozenfox";
  };
}
