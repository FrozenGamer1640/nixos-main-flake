{
  pkgs,
  lib,
  ...
}:
let
  tabWidth = "4";
in
{
  programs.gcc.enable = true;
  programs.neovim = {
    enable = true;
    extraLuaConfig = builtins.readFile ./init.lua;
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      lualine-nvim
      nvim-colorizer-lua
      nvim-treesitter
      nvim-cmp
      nvim-tree-lua
      vim-vsnip
      cmp-vsnip
      cmp-buffer
      cmp-cmdline
      cmp-fuzzy-path
      cmp-nvim-lsp
      cmp-treesitter
      gitgutter
    ]
    ++ (with pkgs.vimPlugins.nvim-treesitter-parsers; [
      nix
      hyprlang
    ]);
  };

  programs.neovim.extraConfig = lib.concatStringsSep "\n" (lib.concatLists [
    (lib.forEach [
      # line numbers
      "number"
      "relativenumber"

      # I like being able to SEE u know hehe
      # highlights only the current line number (not the whole line)
      "cursorlineopt=number"
      "cursorline"

      # tabs and indenting
      "shiftwidth=${tabWidth}"
      "tabstop=${tabWidth}"
      "softtabstop=${tabWidth}"
      "expandtab"
      "autoindent"
      "fileformat=unix"

      # uhmm autocompletion things I'm to lazy to read about tbh
      "wildmode=noselect:full"
      "wildmenu"

      # I'm right handed (even tho I want to be ambidextrous)
      "splitbelow splitright"

      # show tabs, trails and other special chars explicitly
      "list"
      "listchars=tab:⮕\\s,trail:,nbsp:•,extends:…,precedes:…"

      # the good old ruler
      "colorcolumn=80"

      # wrapping settings
      "breakindent"
      "nowrap"
    ] (x: "set ${x}"))

    (lib.forEach [
      # removes all trailing spaces before saving
      "* %s/\\s\\+$//e"
    ] (x: "autocmd BufWritePre ${x}"))

    (lib.forEach [
      "mapleader='\\s'"
    ] (x: "let g:${x}"))

    # quicker vim windows navigation
    (lib.forEach [
      "h"
      "j"
      "k"
      "l"
    ] (x: "map <C-${x}> <C-w>${x}"))

    (lib.forEach [
      # quick global replacement
      "S :%s//g<Left><Left>"

      # toggle wrapping with shift+w
      "<silent> W :set wrap!<cr>"
    ] (x: "nnoremap ${x}"))

    # allow Ctrl/Alt+Backspace to delete the last character in terminals
    (lib.forEach [
      "C"
      "A"
    ] (x: "tmap <${x}-BS> <C-W>."))
  ]);
}

