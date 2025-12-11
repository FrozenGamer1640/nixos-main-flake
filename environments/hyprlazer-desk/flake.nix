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
  };

  outputs =
    {
      packages,
      nixosModules,
      homeModules,
      ...
    }:
    {
      nixosModules.default = {
        imports = with nixosModules.nixosModules; [
          ./nixos
          starship.frosted-kebab
        ];
      };
      homeModules.default = {
        imports = [ ./home ];
      };
    };
}
