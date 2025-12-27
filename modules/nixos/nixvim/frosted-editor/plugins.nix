{
  lib,
  ...
}:
{
  plugins = {
    gitgutter.enable = true;
    lualine.enable = true;
    yazi.enable = true;
    colorizer.enable = true;
    cmp = {
      enable = true;
      settings.sources = (lib.forEach [
        "nvim_lsp"
        "path"
        "buffer"
      ] (x: {name = x;}));
    };
    lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
      };
    };
  };
}

