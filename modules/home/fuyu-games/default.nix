{ unstable-pkgs, ... }:
{
  home.packages = with unstable-pkgs; [
    osu-lazer-bin
    prismlauncher
  ];
}
