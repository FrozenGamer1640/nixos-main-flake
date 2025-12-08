{
  description = "Modules containment sub-flake";

  inputs = {
    packages = {
      type = "path";
      path = "../packages";
    };
    stylix = {
      type = "github";
      owner = "nix-community";
      repo = "stylix";
      ref = "release-25.11";
      inputs.nixpkgs.follows = "packages/nixpkgs";
    };
  };

  outputs =
    {
      stylix,
      ...
    }:
    {
      inherit stylix;
      stylixModules = {
        nixos = stylix.nixosModules.stylix;
        home = stylix.homeModules.stylix;
        macchiato-cat = ./stylix/macchiato-cat;
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
        xdg = ./home/xdg;
        zed-editor = ./home/zed-editor;
        quickshell = ./home/quickshell;
        osu-resources = ./home/osu-resources;
      };
    };
}
