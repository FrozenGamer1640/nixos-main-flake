{
  description = "Home-manager modules containment sub-flake";

  inputs = {
    packages = {
      type = "path";
      path = "../../packages";
    };
    seanime = {
      type = "github";
      owner = "rishabh5321";
      repo = "seanime-flake";
      inputs.nixpkgs.follows = "packages/nixpkgs";
    };
  };

  outputs =
    {
      packages,
      seanime,
      ...
    }:
    {
      homeModules = {
        inherit (seanime.nixosModules) seanime;
        default = ./default.nix;
      }
      // (packages.nixpkgs.lib.genAttrs [
        "dunst"
        "git"
        "zsh"
        "osu-resources"
        "xdg"
        "zed-editor"
        "hyprsunset"
      ] (moduleName: ./${moduleName}));
    };
}
