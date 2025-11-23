{ ... }:
{
  programs.zsh = {
    enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        nixos-update = "sudo nixos-rebuild switch --flake";
        home-update = "home-manager switch --flake";
      };
  };
}
