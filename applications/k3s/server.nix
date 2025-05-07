{ lib, pkgs, config, modulesPath, ... }:
{
    imports = [ ./configuration.nix ];
    config = lib.mkIf config.services.k3s.server.enable {
        services.k3s = {
            role = "server";
            clusterInit = true;
            extraFlags = toString [
                "--disable=traefik"
                "--flannel-backend=host-gw"
                "--tls-san=${config.networking.hostName}"
                "--tls-san=${config.services.k3s.host}"
                "--node-ip=${config.services.k3s.host}"
            ];
        };
    };
}