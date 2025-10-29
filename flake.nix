{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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

  outputs = inputs @ { flake-parts, nixpkgs, nixpkgs-unstable, self, ez-configs, ... }:
  flake-parts.lib.mkFlake { inherit inputs; }
  ({
    debug = true;
    systems = [ "x86_64-linux" ];

    imports = [
      inputs.ez-configs.flakeModule
      inputs.flake-parts.flakeModules.easyOverlay
    ];

    perSystem = { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.foo.overlays.default
          (final: prev:
          let
            attrSetFromDir = import ./modules/flake/attrSetFromDir.nix { lib = final.lib; };
          in
          {
            unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
            local = attrSetFromDir {
              pkgs = final;
              unstable-pkgs = final.unstable;
              directory = ./modules/packages;
            };
          })
        ];
      };
    };

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
  });
}
