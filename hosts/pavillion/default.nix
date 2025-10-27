{ ... }:
{
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.config.allowUnfree = true;
  users.users.frozenfox = {
    isNormalUser = true;
    extraGroups = [ "input" "wheel" "networkmanager" ];
  };

  boot.loader.grub.device = "nodev";
  system.stateVersion = "25.05";
}
