{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprcursor-rose-pine = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };

    seanime = {
      url = "github:rishabh5321/seanime-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { flake-parts, ... }:
  flake-parts.lib.mkFlake { inherit inputs; }
  (
    { withSystem, ... }:
    let
      fuyuHomeModules = {
        dunst = ./modules/home/dunst;
        eww = ./modules/home/eww;
        git = ./modules/home/git;
        gpg = ./modules/home/gpg;
        zsh = ./modules/home/zsh;
        hyprland = ./modules/home/hyprland;
        obs-studio = ./modules/home/obs-studio;
        vesktop = ./modules/home/vesktop;
        xdg = ./modules/home/xdg;
        zed-editor = ./modules/home/zed-editor;
        fuyu-games = ./modules/home/fuyu-games;
      };
      fuyuNixosModules = {
        pipewire = ./modules/nixos/pipewire.nix;
        fonts = ./modules/nixos/fonts.nix;
        locale-es-cr = ./modules/nixos/locale-es-cr.nix;
      };
      fuyuGenericModules= {
        stylix = ./modules/stylix;
      };
    in
    {
      debug = true;
      systems = [ "x86_64-linux" ];

      imports = [
        inputs.home-manager.flakeModules.home-manager
      ];

      perSystem = { pkgs, ... }: {
        packages = {
          discord-presence-lsp = import ./modules/packages/discord-presence-lsp.nix { inherit pkgs; };
        };
      };

      flake = {
        nixosConfigurations.pavillion = withSystem "x86_64-linux" (
          { config, inputs', pkgs, ... }:
          inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs inputs';
              inherit fuyuGenericModules fuyuNixosModules;
              local-pkgs = config.packages;
              unstable-pkgs = import inputs.nixpkgs-unstable { inherit (pkgs) system; allowUnfree = true;};
            };

            modules = with fuyuNixosModules; [
              ./modules/nixos
              ./hosts/pavillion
              fuyuGenericModules.stylix
              fonts locale-es-cr
              pipewire
            ];
          }
        );

        homeConfigurations = {
          "frozenfox" = withSystem "x86_64-linux" (
            { config, inputs', pkgs, ... }:
            inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = {
                inherit inputs inputs';
                inherit fuyuGenericModules fuyuHomeModules;
                local-pkgs = config.packages;
                unstable-pkgs = import inputs.nixpkgs-unstable { inherit (pkgs) system; allowUnfree = true;};
              };

              modules = [
                ./modules/home
                ./users/frozenfox.nix
              ];
            }
          );
        };
      };
    }
  );
}
