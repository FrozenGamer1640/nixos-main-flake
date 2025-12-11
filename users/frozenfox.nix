{
  pkgs,
  ...
}:
{
  imports = [
    ./anki.nix
    ./thunderbird.nix
  ];

  modules.home.services.seanime.enable = true; # This sucks if you ask me

  programs = {
    jq.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    youtube-music
    wl-clicker
    lutris
    winetricks
    osu-lazer-bin
    prismlauncher
  ];
}
