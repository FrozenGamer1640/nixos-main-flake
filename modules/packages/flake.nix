{
  description = "Packages and overlays management sub-flake";

  inputs = {
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
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }:
    {
      inherit nixpkgs nixpkgs-unstable;

      forAllSystems =
        nixpkgs-input: function:
        nixpkgs-input.lib.genAttrs [
          # Add all the systems that your flake will support
          "x86_64-linux"
        ] (system: function nixpkgs-input.legacyPackages.${system});

      withSystem =
        system: nixpkgs:
        (import nixpkgs {
          inherit system;
          allowUnfree = true;
        });

      packages = self.forAllSystems nixpkgs (pkgs: {
        osu-resources = pkgs.callPackage ./osu-resources.nix;
        discord-presence-lsp = pkgs.callPackage ./discord-presence-lsp.nix;
      });
    };
}
