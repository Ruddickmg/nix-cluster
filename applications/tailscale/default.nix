{ config, lib, pkgs, ... }:
{
    imports = [
        ./connection.nix
    ];

    config = lib.mkIf config.services.tailscale.enable {
        environment.systemPackages = [
            pkgs.tailscale
        ];
        networking.firewall = {
            trustedInterfaces = [ "tailscale0" ];
            allowedUDPPorts = [ config.services.tailscale.port ];
        };
    };
}
