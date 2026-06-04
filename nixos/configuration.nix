{ ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "main";
  networking.firewall.allowedTCPPorts = [ 22 ]; # TODO: configurate firewall
  networking.firewall.allowedUDPPorts = [ 51820 ];

  system.stateVersion = "26.05";
}