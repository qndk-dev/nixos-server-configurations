{ config, pkgs, ... }:
{
  sops.secrets.pg-server-cert = {
    sopsFile = ./secrets/pg.yaml;
    owner = "postgres";
  };
  sops.secrets.pg-server-key = {
    sopsFile = ./secrets/pg.yaml;
    owner = "postgres";
  };
  sops.secrets.pg-ca-cert = {
    sopsFile = ./secrets/pg.yaml;
    owner = "postgres";
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;

    settings = {
      listen_addresses = "10.0.0.1"; # wg
      ssl = true;
      ssl_cert_file = config.sops.secrets.pg-server-cert.path;
      ssl_key_file  = config.sops.secrets.pg-server-key.path;
      ssl_ca_file   = config.sops.secrets.pg-ca-cert.path;
    };

    authentication = ''
      hostssl all all 10.0.0.0/24 cert clientcert=verify-full
    '';
  };

  networking.firewall.interfaces.wg0.allowedTCPPorts = [ 5432 ];
}