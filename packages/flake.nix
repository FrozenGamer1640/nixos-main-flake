{
  description = "Packages and overlays management sub-flake";

  inputs = {
    systems.url = "github:nix-systems/default-linux";
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-24.11";
    };
    nixpkgs-unstable = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    hyprland = {
      type = "github";
      owner = "hyprwm";
      repo = "Hyprland";
      ref = "nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    rose-pine-cursor = {
      type = "github";
      owner = "ndom91";
      repo = "rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
    vieb = {
      type = "github";
      owner = "tejing1";
      repo = "vieb-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    copyparty = {
      type = "github";
      owner = "9001";
      repo = "copyparty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      systems,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }:
    {
      inherit nixpkgs nixpkgs-unstable;

      eachSystem = nixpkgs.lib.genAttrs (import systems); # Directly extracted from the Hyprland's flake btw

      forAllSystems =
        nixpkgs-input: function: self.eachSystem (system: function nixpkgs-input.legacyPackages.${system});

      withSystem =
        system: nixpkgs:
        (import nixpkgs {
          inherit system;
          allowUnfree = true;
        });

      overlays = {
        inherit (inputs.hyprland.overlays) hyprland-packages;
        copyparty = inputs.copyparty.overlays.default;
        rose-pine-hyprcursor = final: prev: {
          rose-pine-cursor = inputs.rose-pine-cursor.packages.${prev.stdenv.hostPlatform.system}.default;
        };
        default = final: prev: self.packages.${prev.stdenv.hostPlatform.system};
      };

      packages = self.forAllSystems nixpkgs-unstable (pkgs: {
        osu-resources = pkgs.callPackage ./osu-resources.nix;
        discord-presence-lsp = pkgs.callPackage ./discord-presence-lsp.nix;
        vieb = (inputs.vieb.packagesFunc pkgs).vieb;
      });

      nixosModules = {
        copyparty = inputs.copyparty.nixosModules.default;
      };
    };
}
