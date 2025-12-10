{
  description = "A Hyprland setup designed to be as similar as possible to Osu!Lazer's UI";

  inputs = {
    packages = {
      type = "path";
      path = "../../packages";
    };
    homeModules = {
      type = "path";
      path = "../../modules/home";
    };
  };

  outputs =
    {
      packages,
      homeModules,
      ...
    }:
    {
      nixosModules.default = {
        imports = [ ./nixos ];
      };
      homeModules.default = {
        imports = [ ./home ];
      };
    };
}
