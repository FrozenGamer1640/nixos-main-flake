{
  description = "Hosts containment sub-flake";

  inputs = {
    packages = {
      type = "path";
      path = "./../packages";
    };
    nixosModules = {
      type = "path";
      path = "./../modules/nixos";
    };
    stylixModules = {
      type = "path";
      path = "./../modules/stylix";
    };
  };

  outputs =
    {
      packages,
      nixosModules,
      stylixModules,
      ...
    }:
    let
      withSystem = packages.withSystem;
      importHost = hostName: [
        ./${hostName}
        ./${hostName}/hardware-configuration.nix
        nixosModules.nixosModules.default
        nixosModules.stylixModules.nixos
      ];
    in
    {
      nixosConfigurations = {
        # This one is an HP Pavillion (Gaming) Laptop btw
        pavillion = packages.nixpkgs.lib.nixosSystem {
          pkgs = withSystem "x86_64-linux" packages.nixpkgs;
          modules =
            (importHost "pavillion")
            ++ (with nixosModules.nixosModules; [
              packages.withAllOverlays
              stylixModules.stylixModules.macchiato-cat
              copyparty
              fonts
              locale-es-cr
              pipewire
              steam
            ]);
        };
      };
    };
}
