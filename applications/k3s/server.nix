{ lib, pkgs, config, modulesPath, ... }:
{
    imports = [ ./common.nix ];
    config = lib.mkIf config.services.k3s.server.enable {
        networking.hostName = "server-node";
        services.k3s = {
            role = "server";
            clusterInit = true;
            extraFlags = toString [
                "--disable=traefik"
                "--flannel-backend=host-gw"
                "--tls-san=${config.services.k3s.host}"
                "--tls-san=cluster"
                "--bind-address=${config.services.k3s.host}"
                "--advertise-address=${config.services.k3s.host}"
                "--node-ip=${config.services.k3s.host}"
            ];
        };
    };
}