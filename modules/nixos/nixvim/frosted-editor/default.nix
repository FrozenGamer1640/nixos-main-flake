{
  ...
}:
{
  programs.nixvim = {
    enable = true;
    imports = [
      ./settings.nix
      ./plugins.nix
    ];
  };
}

