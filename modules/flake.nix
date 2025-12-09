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
    seanime = {
      type = "github";
      owner = "rishabh5321";
      repo = "seanime-flake";
      inputs.nixpkgs.follows = "packages/nixpkgs";
    };
  };

  outputs =
    {
      packages,
      stylix,
      seanime,
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
        inherit (packages.nixosModules) copyparty;
        default = ./nixos;
        fonts = ./nixos/fonts.nix;
        locale-es-cr = ./nixos/locale-es-cr.nix;
        pipewire = ./nixos/pipewire.nix;
        steam = ./nixos/steam.nix;
      };
      homeModules = {
        inherit (seanime.nixosModules) seanime;
        default = ./home;
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
