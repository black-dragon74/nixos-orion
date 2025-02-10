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

  networking.nftables = {
    enable = true;
    flushRuleset = true;

    # We need masquerading on eth to allow docker
    # containers to talk to the internet.
    tables."docker" = {
      enable = false;
      family = "inet";
      content = ''
        				chain postrouting {
        					type nat hook postrouting priority srcnat; policy accept;
        					
                  oifname "enp3s0" ip daddr != 172.18.0.0/16 masquerade
                  oifname "enp3s0" ip6 daddr != fd35:4ead:dcd4::/64 masquerade
        				}
      '';
    };
  };
}
