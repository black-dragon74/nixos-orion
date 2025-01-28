{ config, pkgs, ... }:

{
  networking.firewall.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 80 443 465 ];
  networking.firewall.allowedUDPPorts = [ 443 ];

  networking.nftables = {
    enable = true;
    flushRuleset = true;

    # We need masquerading on eth to allow docker
    # containers to talk to the internet.
    tables."docker" = {
      enable = true;
      family = "inet";
      content = ''
				chain postrouting {
					type nat hook postrouting priority srcnat; policy accept;
					
					oifname "enp3s0" masquerade;
				}
      '';
    };
  };
}
