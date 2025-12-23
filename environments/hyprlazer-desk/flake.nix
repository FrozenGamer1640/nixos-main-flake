fuyupkgs:
{
  nixosModules.default = {
    imports = with fuyupkgs.nixosModules; [
      ./nixos
      starship.frosted-kebab
      stylix
    ];
  };
  homeModules.default = {
    imports = with fuyupkgs.homeModules; [
      ./home
      osu-resources
      stylix
    ];
  };
}

