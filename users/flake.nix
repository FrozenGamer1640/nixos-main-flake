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
        modules.stylixModules.home
      ];
    in
    {
      homeConfigurations = {
        "frozenfox" = homeConfiguration {
          pkgs = packages.withSystem "x86_64-linux" packages.nixpkgs;
          modules =
            (importUser "frozenfox")
            ++ (with modules.homeModules; [
              # Hey, this is a module btw
              (packages.withOverlays (
                with packages.overlays;
                [
                  default
                  copyparty
                  hyprland-packages
                ]
              ))
              modules.stylixModules.macchiato-cat
              git
              xdg
              gpg
              dunst
              zsh
              eww
              hyprland
              kitty
              zed-editor
              quickshell
              osu-resources
              seanime
            ]);
        };
      };
    };
}
