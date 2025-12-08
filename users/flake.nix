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
    modules = {
      type = "path";
      path = "./../modules";
    };
  };

  outputs =
    {
      home-manager,
      packages,
      modules,
      ...
    }:
    let
      homeConfiguration = home-manager.lib.homeManagerConfiguration;
      importUser = userName: [
        ./${userName}.nix
        modules.homeModules.default
      ];
    in
    {
      homeConfigurations = {
        "frozenfox" = homeConfiguration {
          pkgs = packages.withSystem "x86_64-linux" packages.nixpkgs;
          modules =
            (importUser "frozenfox")
            ++ (with modules.homeModules; [
              modules.stylixModules.default
              git
              xdg
              gpg
              dunst
              zsh
              eww
              hyprland
              kitty
              obs-studio
              vesktop
              zed-editor
              quickshell
              fuyu-games
              osu-resources
              # inputs.seanime.nixosModules.seanime
            ]);
        };
      };
    };
}
