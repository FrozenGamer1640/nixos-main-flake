{
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    extraConfig =
    ''
    	set number
	set relativenumber
    '';
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
