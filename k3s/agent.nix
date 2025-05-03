{ lib, pkgs, modulesPath, ... }:
{
    imports = [
      ./common.nix
    ];
    services.k3s = {
        role = "agent";
        serverAddr = "https://192.168.0.153:6443";
        extraFlags = toString [
            "--disable=traefik"
            "--server https://192.168.0.153:6443"
        ];
    };
}