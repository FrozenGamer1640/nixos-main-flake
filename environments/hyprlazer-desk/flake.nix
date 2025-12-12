{
  description = "A Hyprland setup designed to be as similar as possible to Osu!Lazer's UI";

  inputs = {
    packages = {
      type = "path";
      path = "../../packages";
    };
    nixosModules = {
      type = "path";
      path = "../../modules/nixos";
    };
    homeModules = {
      type = "path";
      path = "../../modules/home";
    };
    stylixModules = {
      type = "path";
      path = "../../modules/stylix";
    };
  };

  outputs =
    inputs@{
      packages,
      ...
    }:
    let
      inherit (inputs.nixosModules) nixosModules;
      inherit (inputs.homeModules) homeModules;
      inherit (inputs.stylixModules) stylixModules;
    in
    {
      nixosModules.default = {
        imports = with nixosModules; [
          ./nixos
          starship.frosted-kebab
          stylixModules.nixos
        ];
      };
      homeModules.default = {
        imports = with homeModules; [
          ./home
          osu-resources
          stylixModules.home
        ];
      };
    };
}
