{
  description = "Packages and overlays management sub-flake";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-25.11";
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
      nixpkgs,
      nixpkgs-unstable,
      ...
    }:
    {
      inherit nixpkgs nixpkgs-unstable;

      # Add all the systems your flake will support
      systems = [
        "x86_64-linux"
      ];
      eachSystem = nixpkgs.lib.genAttrs self.systems; # Extracted from the Hyprland's flake btw

      forAllSystems =
        nixpkgs-input: function: self.eachSystem (system: function (self.withSystem system nixpkgs-input));

      withSystem =
        system: nixpkgs:
        (import nixpkgs {
          inherit system;
          config.allowUnfree = true; # You migth wanna delete this, but I really hate defining predications everytime
        });

      withOverlays = overlays: { nixpkgs.overlays = overlays; };
      withAllOverlays = self.withOverlays (builtins.attrValues self.overlays);

      overlays = {
        inherit (inputs.hyprland.overlays) hyprland-packages;
        copyparty = inputs.copyparty.overlays.default;
        default = final: prev: {
          osu-resources = final.callPackage ./osu-resources.nix { };
          discord-presence-lsp = final.callPackage ./discord-presence-lsp.nix { };
          vieb = (inputs.vieb.packagesFunc final).vieb;
        };
      };

      packages = self.forAllSystems nixpkgs-unstable (pkgs: {
      });

      nixosModules = {
        copyparty = inputs.copyparty.nixosModules.default;
      };
    };
}
