{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    ez-configs = {
      url = "github:ehllie/ez-configs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { flake-parts, ... }:
  flake-parts.lib.mkFlake { inherit inputs; }
  {
    debug = true;
    systems = [ "x86_64-linux" ];

    imports = [
      inputs.ez-configs.flakeModule
    ];

    ezConfigs = {
      root = ./.;
      earlyModuleArgs = { inherit inputs; };

      globalArgs = {
        stylix = {
          nixos = inputs.stylix.nixosModules.stylix;
          home = inputs.stylix.homeModules.stylix;
          config = ./modules/stylix;
        };
      };

      nixos = {
        configurationsDirectory = ./hosts;
        modulesDirectory = ./modules/nixos;
      };

      home = {
        configurationsDirectory = ./users;
        modulesDirectory = ./modules/home;
      };
    };
  };
}
