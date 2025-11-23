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
      fuyuHomeModules = (with builtins;
        inputs.nixpkgs.lib.genAttrs
          (filter
            (name: typeOf (readDir ./modules/home/${name}) == "set")
            (attrNames (readDir ./modules/home))
          )
          (name: ./modules/home/${name})
      );
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
              #   inputs.stylix.homeModules.stylix
              #   fuyuGenericModules.stylix
              #   dunst git gpg xdg
              #   eww
              #   hyprland
              #   obs-studio
              #   vesktop
              #   zed-editor
              ];
            }
          );
        };
      };
    }
  );
}
