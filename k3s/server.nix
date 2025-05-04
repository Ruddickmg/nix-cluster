{ lib, pkgs, modulesPath, ... }:
{
    imports = [
        ./common.nix
    ];
    networking.hostName = "server-node";
    services.k3s = {
        role = "server";
        clusterInit = true;
        extraFlags = toString [
            "--disable=traefik"
            "--flannel-backend=host-gw"
            "--tls-san=192.168.0.153"
            "--tls-san=cluster"
            "--bind-address=192.168.0.153"
            "--advertise-address=192.168.0.153"
            "--node-ip=192.168.0.153"
        ];
    };
}