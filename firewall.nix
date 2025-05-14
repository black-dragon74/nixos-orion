{ config, pkgs, ... }:

{
  networking.firewall.enable = true;

  networking.firewall.allowedTCPPorts = [
    22
    80
    443
    465
  ];
  networking.firewall.allowedUDPPorts = [ 443 ];
  networking.firewall.extraInputRules = ''
    ip saddr 172.18.0.0/16 tcp dport 9100 accept comment "Allow Docker to Node Exporter"
    ip saddr 172.18.0.0/16 tcp dport 9200 accept comment "Allow Docker to cAdvisor"
  '';

  networking.nftables = {
    enable = true;
  };
}
