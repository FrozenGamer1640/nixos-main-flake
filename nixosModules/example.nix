{
  lib,
  config,
  ...
}: {
  options = {
    exampleModule.enable = lib.mkEnableOption "enables Module";
  };

  config = lib.mkIf config.exampleModule.enable {
    option1 = 5;
    option2 = true;
  };
}
