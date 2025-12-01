{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Fuyuka.nix";
      user.email = "fuyuka.nix@proton.me";
      init = {
        defaultBranch = "main";
      };
      core = {
        excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
      };
    };
  };
}
