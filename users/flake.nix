{
  description = "Users containment sub-flake";

  inputs = {
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "release-25.11";
      inputs.nixpkgs.follows = "packages/nixpkgs";
    };
    packages = {
      type = "path";
      path = "./../packages";
    };
    homeModules = {
      type = "path";
      path = "./../modules/home";
    };
    stylixModules = {
      type = "path";
      path = "./../modules/stylix";
    };
    environments = {
      type = "path";
      path = "./../environments";
    };
  };

  outputs =
    {
      home-manager,
      packages,
      homeModules,
      stylixModules,
      environments,
      ...
    }:
    let
      homeConfiguration = home-manager.lib.homeManagerConfiguration;
      importUser = userName: [
        ./${userName}.nix
        homeModules.homeModules.default
        stylixModules.stylixModules.home
        { home.username = "${userName}"; }
      ];
    in
    {
      homeConfigurations = {
        "frozenfox" = homeConfiguration {
          pkgs = packages.withSystem "x86_64-linux" packages.nixpkgs;
          modules =
            (importUser "frozenfox")
            ++ (with homeModules.homeModules; [
              packages.withAllOverlays
              stylixModules.stylixModules.macchiato-cat
              environments.hyprlazer-desk.homeModules.default
              git
              xdg
              gpg
              dunst
              zsh
              seanime
            ]);
        };
      };
    };
}
