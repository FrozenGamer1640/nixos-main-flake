{ lib, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = lib.mkForce "0.8";
    };
  };
}
