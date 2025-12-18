{
  pkgs,
  ...
}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "zed-color-highlight";
  version = "bb532223ad71936a25fe492d94a519a60f3a7814";
  cargoHash = "sha256-etK+9fcKS+y+0C36vJrMkQ0yyVSpCW/DLKg4nTw3LrE=";
  cargoBuildFlags = "--package zed-color-highlight";
  src = pkgs.fetchFromGitHub {
    owner = "huacnlee";
    repo = "color-lsp";
    rev = version;
    hash = "sha256-U0pTzW2PCgMxVsa1QX9MC249PXXL2KvRSN1Em2WvIeI=";
  };
}
