{
  config,
  lib,
  local-pkgs,
  ...
}:
let
  cfg = config.programs.osu-resources;
in
{
  options.programs.osu-resources = {
    enable = lib.mkEnableOption "Expose osu!resources' samples and textures for other programs";
    targetDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.local/share/osu-assets";
      description = "Directory where osu!resources will be exposed";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ local-pkgs.osu-resources ];
    home.sessionVariables.OSU_RESOURCES = cfg.targetDir;
    home.file."${cfg.targetDir}" = {
      source = "${local-pkgs.osu-resources}";
      target = cfg.targetDir;
    };
  };
}
