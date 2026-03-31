{ config, pkgs, ... }:

{
  services.firewalld = {
    enable = false;

    zones."trusted" = {
      interfaces = [
        "docker0"
        "tailscale0"
      ];
      masquerade = true;
    };

    zones."nixos-fw-default".masquerade = true;
  };

  networking.firewall = {
    enable = false;
    backend = "firewalld";
  };

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
    ip saddr 172.18.0.0/16 tcp dport 8082 accept comment "Allow Docker to Traefik metrics"
  '';

  networking.nftables = {
    enable = false;
    tables."docker" = {
      enable = false;
      family = "inet";
      content = ''
        chain postrouting {
          type nat hook postrouting priority srcnat; policy accept;

          oifname "enp3s0" ip daddr != 172.18.0.0/16 masquerade
          oifname "enp3s0" ip6 daddr != fd35:4ead:dcd4::/64 masquerade

          #ip saddr 10.29.74.0/24 ip daddr 10.29.74.55 udp dport 53 snat to 10.29.74.54
          #ip saddr 10.29.74.0/24 ip daddr 10.29.74.55 tcp dport 53 snat to 10.29.74.54
        }

        chain prerouting {
          type nat hook prerouting priority dstnat; policy accept;

          #ip daddr 10.29.74.54 udp dport 53 dnat to 10.29.74.55:53
          #ip daddr 10.29.74.54 tcp dport 53 dnat to 10.29.74.55:53
        }
      '';
    };
  };
}
