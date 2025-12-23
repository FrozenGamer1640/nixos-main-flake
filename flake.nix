{
  inputs = {
    fuyupkgs = {
      type = "path";
      path = "./packages";
    };
  };

  outputs =
    {
      fuyupkgs,
      ...
    }:
    let
      environments = import ./environments fuyupkgs;
    in
    {
      nixosConfigurations = import ./hosts fuyupkgs environments;
      homeConfigurations = import ./users fuyupkgs environments;
    };
}
