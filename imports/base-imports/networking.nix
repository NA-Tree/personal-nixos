  GNU nano 8.4                                                 imports/base-imports/networking.nix                                                           
{config, ...}:
{
    networking.hostName = "solid-system-HMI";           # Define your hostname.
    networking.networkmanager.enable = true;            # Enable networking
    # networking.wireless.enable = true;                # Enables wireless support via wpa_supplicant.

    # enable firewall
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 80 443 7772 ];
        allowedUDPPortRanges = [
            { from = 4000; to = 4007; }
            { from = 8000; to = 8010; }
        ];

        allowedUDPPorts = [ config.services.tailscale.port ];


    };

    # Configure network proxy or VPN if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Tell the firewall to implicitly trust packets routed over Tailscale:
    services.tailscale.enable = true;
    networking.firewall.trustedInterfaces = [ "tailscale0" ];

}