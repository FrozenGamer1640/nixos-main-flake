{
  description = "Nixos modules containment sub-flake";

  inputs = {
    packages = {
      type = "path";
      path = "../packages";
    };
  };

  outputs =
    {
      packages,
      ...
    }:
    {
      nixosModules = {
        inherit (packages.nixosModules) copyparty;
      }
      // (packages.nixpkgs.lib.genAttrs [
        "default"
        "fonts"
        "locale-es-cr"
        "pipewire"
        "steam"
      ] (moduleName: ./${moduleName}.nix));
    };
}
