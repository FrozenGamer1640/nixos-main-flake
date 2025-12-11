{
  lib,
  ...
}:
{
  stylix.targets.kitty.enable = true;
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = lib.mkForce "0.8";
    };
  };
}
