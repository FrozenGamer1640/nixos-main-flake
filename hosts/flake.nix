{
  description = "Hosts containment sub-flake";

  inputs = {
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
      packages,
      modules,
      ...
    }:
    let
      withSystem = packages.withSystem;
      importHost = hostName: [
        ./${hostName}
        ./${hostName}/hardware-configuration.nix
        modules.nixosModules.default
        modules.stylixModules.nixos
      ];
    in
    {
      nixosConfigurations = {
        # This one is an HP Pavillion (Gaming) Laptop btw
        pavillion = packages.nixpkgs.lib.nixosSystem {
          pkgs = withSystem "x86_64-linux" packages.nixpkgs;
          overlays = with packages.overlays; [
            default
            copyparty
            hyprland-packages
            rose-pine-hyprcursor
          ];
          modules =
            (importHost "pavillion")
            ++ (with modules.nixosModules; [
              modules.stylixModules.macchiato-cat
              fonts
              locale-es-cr
              pipewire
              steam
              vieb-nix
            ]);
        };
      };
    };
}
