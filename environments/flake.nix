{
  description = "Environment flakes containment sub-flake";

  inputs = {
    hyprlazer-desk = {
      type = "path";
      path = "./hyprlazer-desk";
    };
  };

  outputs =
    {
      hyprlazer-desk,
      ...
    }:
    {
      inherit hyprlazer-desk;
    };
}
