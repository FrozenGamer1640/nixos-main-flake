{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Las herramientas que necesitas en tu entorno.
  buildInputs = with pkgs; [
    rustc       # El compilador de Rust
    cargo       # El gestor de paquetes de Rust
    rustfmt     # El formateador de código
    clippy      # El linter de Rust

    # Bibliotecas nativas comunes
    # Algunas dependencias de Rust pueden necesitar bibliotecas C/C++
    openssl
    pkg-config
    libiconv
  ];

  # Variables de entorno opcionales
  RUST_SRC_PATH = pkgs.rustPlatform.rustLibSrc;

  # Algunas dependencias de Rust pueden necesitar estas variables
  # Por ejemplo, la biblioteca `openssl-sys` en Rust
  OPENSSL_STATIC = 1;
  PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

  # Esto asegura que el entorno de desarrollo se cargue correctamente
  shellHook = ''
    echo "¡Entorno de desarrollo de Rust listo!"
  '';
}