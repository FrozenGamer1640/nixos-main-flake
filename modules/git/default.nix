{ ... }:

{
  programs.git = {
    enable = true;
    userName = "FrozenGamer1640";
    userEmail = "gamercfp@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      core = {
        excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
      };
    };
  };
}
