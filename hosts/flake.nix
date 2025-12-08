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
      ];
    in
    {
      nixosConfigurations = {
        # This one is an HP Pavillion (Gaming) Laptop btw
        pavillion = packages.nixpkgs.lib.nixosSystem {
          pkgs = withSystem "x86_64-linux" packages.nixpkgs;
          modules =
            (importHost "pavillion")
            ++ (with modules.nixosModules; [
              modules.generalModules.stylix
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
