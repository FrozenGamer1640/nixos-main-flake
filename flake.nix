{
  description = "FrozenFox's system main flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

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
  };

  outputs = { home-manager, nixpkgs, nur, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
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
        ];
        extraSpecialArgs = { inherit inputs; } // extraArgs;
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