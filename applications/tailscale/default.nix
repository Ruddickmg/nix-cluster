{ config, lib, pkgs, ... }:
{
    imports = [
        ./connection.nix
    ];

    config = lib.mkIf config.services.tailscale.enable {

      # make the tailscale command usable to users
        environment.systemPackages = [
            pkgs.tailscale
        ];

        networking.firewall = {
            # allow traffic from your Tailscale network
            trustedInterfaces = [ "tailscale0" ];

            # allow the Tailscale UDP port through the firewall
            allowedUDPPorts = [ config.services.tailscale.port ];
        };
    };
}
