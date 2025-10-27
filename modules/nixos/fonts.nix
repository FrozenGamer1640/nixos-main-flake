{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
      jetbrains-mono
      openmoji-color
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.noto
      libre-caslon
      babelstone-han
      symbola
    ];

    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans" "Hack Nerd Font" ];
        serif = [ "Libre Caslon Text" ];
        monospace = [ "Hack Nerd Font Mono" ];
        emoji = [ "OpenMoji Color" ];
      };
    };
  };
}
