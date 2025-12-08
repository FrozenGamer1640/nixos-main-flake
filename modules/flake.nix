{
  description = "Modules containment sub-flake";

  inputs = {
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      ...
    }:
    {
      stylixModules = {
        default = ./stylix;
      };
      nixosModules = {
        default = ./nixos;
        fonts = ./nixos/fonts.nix;
        locale-es-cr.nix = ./nixos/locale-es-cr.nix;
        pipewire.nix = ./nixos/pipewire.nix;
        steam = ./nixos/steam.nix;
      };
      homeModules = {
        dunst = ./home/dunst;
        eww = ./home/eww;
        git = ./home/git;
        gpg = ./home/gpg;
        zsh = ./home/zsh;
        kitty = ./home/kitty;
        hyprland = ./home/hyprland;
        obs-studio = ./home/obs-studio;
        vesktop = ./home/vesktop;
        xdg = ./home/xdg;
        zed-editor = ./home/zed-editor;
        quickshell = ./home/quickshell;
        fuyu-games = ./home/fuyu-games;
        osu-resources = ./home/osu-resources;
      };
    };
}
