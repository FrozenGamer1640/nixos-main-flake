{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
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
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };

    seanime = {
      url = "github:rishabh5321/seanime-flake";
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
      earlyModuleArgs = {
        inherit inputs;
        stylixModule = ./modules/stylix;
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
