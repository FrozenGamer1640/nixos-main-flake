{ config, lib, inputs, pkgs, ...}:
let
  modules = import ../../modules/default.nix;
in
{
    home.stateVersion = "25.05";
    imports = [
        # gui
        modules.eww
        modules.dunst
        modules.wofi
        modules.hyprland
        modules.vscode

        # system
        modules.xdg
        modules.packages
    ];
}


# { config, lib, inputs, ...}:

# {
#     imports = [ ../../modules/default.nix ];
#     config.modules = {
#         # gui
#         #firefox.enable = true;
#         #foot.enable = true;
#         ##eww.enable = true;
#         ##dunst.enable = true;
#         ##hyprland.enable = true;
#         ##wofi.enable = true;
#         vscode.enable = true;

#         # cli
#         #nvim.enable = true;
#         #zsh.enable = true;
#         ##git.enable = true;
#         #gpg.enable = true;
#         #direnv.enable = true;

#         # system
#         ##xdg.enable = true;
#         ##packages.enable = true;
#     };
# }
