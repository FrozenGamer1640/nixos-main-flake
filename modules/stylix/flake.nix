{
  description = "Stylix modules containment sub-flake";

  inputs = {
    packages = {
      type = "path";
      path = "../../packages";
    };
    stylix = {
      type = "github";
      owner = "nix-community";
      repo = "stylix";
      ref = "release-25.11";
      inputs.nixpkgs.follows = "packages/nixpkgs";
    };
  };

  outputs =
    {
      packages,
      stylix,
      ...
    }:
    {
      stylixModules =
        (packages.nixpkgs.lib.genAttrs [
          "macchiato-cat"
        ] (moduleName: ./${moduleName}))
        // {
          nixos = stylix.nixosModules.stylix;
          home = stylix.homeModules.stylix;
        };
    };
}
