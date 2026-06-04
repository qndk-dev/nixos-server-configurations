{ config, ... }:
{
  sops.secrets.wg-private-key = {
    sopsFile = ./secrets/wg.yaml;
  };
  sops.secrets.wg-peers = {
    sopsFile = ./secrets/wg.yaml;
  };

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.1/24" ];
    listenPort = 51820;
    privateKeyFile = config.sops.secrets.wg-private-key.path;
    peers = import config.sops.secrets.wg-peers.path;
  };
}