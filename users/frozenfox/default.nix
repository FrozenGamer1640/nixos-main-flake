{
  pkgs,
  config,
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

  home.homeDirectory = "/home/${config.home.username}";
  home.packages = with pkgs; [
    youtube-music
    wl-clicker
    lutris
    winetricks
    osu-lazer-bin
    prismlauncher
    gh
  ];

  programs.zsh.shellAliases = {
    nixos-rsrf = "sudo nixos-rebuild switch --no-write-lock-file --flake ~/mysystem/#pavillion";
    nixos-rbrf = "sudo nixos-rebuild boot --no-write-lock-file --flake ~/mysystem/#pavillion";
    home-srf = "home-manager switch --no-write-lock-file --flake ~/mysystem/#frozenfox";
  };
}
