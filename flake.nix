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
  ({ ... }:
  let
    attrSetFromDir = import ./modules/flake/attrSetFromDir.nix { inherit (inputs.nixpkgs) lib; };
    xtraArgs = {
      inherit inputs;
      inherit attrSetFromDir;
      stylixModule = ./modules/stylix;
      localPkgsPath = ./modules/packages;
    };
  in
  {
    debug = true;
    systems = [ "x86_64-linux" ];

    imports = [
      inputs.ez-configs.flakeModule
    ];

    ezConfigs = {
      root = ./.;
      earlyModuleArgs = xtraArgs;
      globalArgs = xtraArgs;

      nixos = {
        configurationsDirectory = ./hosts;
        modulesDirectory = ./modules/nixos;

        hosts = {
          pavillion.userHomeModules = [ "frozenfox" ];
        };
      };

      home = {
        configurationsDirectory = ./users;
        modulesDirectory = ./modules/home;
      };
    };
  });
}
