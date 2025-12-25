{
  pkgs,
  lib,
  ...
}:
let
  tabWidth = "4";
in
{
  programs.neovim = {
    enable = true;
    extraConfig = lib.concatStringsSep "\n" (lib.concatLists [
      (lib.forEach [
        "number"
        "relativenumber"

        "shiftwidth=${tabWidth}"
        "tabstop=${tabWidth}"
        "softtabstop=${tabWidth}"
        "expandtab"
        "autoindent"
        "fileformat=unix"

        "cursorlineopt=number"
        "cursorline"
        "wildmode=noselect:full"
        "splitbelow splitright"
      ] (x: "set ${x}"))

      (lib.forEach [
        "h"
        "j"
        "k"
        "l"
      ] (x: "map <C-${x}> <C-w>${x}"))

      (lib.forEach [
        "S :%s//g<Left><Left>"
      ] (x: "nnoremap ${x}"))

      (lib.forEach [
        "* %s/\\s\\+$//e"
      ] (x: "autocmd BufWritePre ${x}"))
    ]);
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      nvim-colorizer-lua
      nvim-treesitter
    ]
    ++ (with pkgs.vimPlugins.nvim-treesitter-parsers; [
      nix
      hyprlang
    ]);

  };
}
