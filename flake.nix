{
  description = "FrozenFox's system main flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    seanime = {
      url = "github:rishabh5321/seanime-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
  };

  outputs = { home-manager, nixpkgs, unstable-nixpkgs, nur, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    unstable-pkgs = import unstable-nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;

    mkSystem = { hostname }:
      lib.nixosSystem {
        inherit system;
        modules = [
          # General configuration
          ./modules/system/configuration.nix
          # Host-specific hardware config
          (./. + "/hosts/${hostname}/hardware-configuration.nix")
          # Stylix
          inputs.stylix.nixosModules.stylix
        ];
        specialArgs = { inherit inputs; };
      };

    mkUser = { user, hostname, extraArgs ? { } }:
      home-manager.lib.homeManagerConfiguration {
        #inherit system;
        inherit pkgs;
        modules = [
          # Set username and home directory from the function arguments
          {
            home.username = user;
            home.homeDirectory = "/home/${user}";
          }
          # User-specific configuration
          (./. + "/hosts/${hostname}/user.nix")
          # Stylix
          inputs.stylix.homeModules.stylix
        ];
        extraSpecialArgs = { inherit inputs unstable-pkgs; } // extraArgs;
      };
  in {
    nixosConfigurations = {
      pavillion = mkSystem { hostname = "pavillion"; };
    };

    homeConfigurations = {
      frozenfox = mkUser {
        user = "frozenfox";
        hostname = "pavillion";
      };
    };
  };
}
