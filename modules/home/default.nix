{ inputs, stylixModule, ... }:
{
  imports = [
    inputs.stylix.homeModules.stylix
    stylixModule
  ];
}
