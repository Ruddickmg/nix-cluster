{ lib, pkgs, modulesPath, ... }:
{
    environment.systemPackages = with pkgs; [
        k3s
    ];
    networking.firewall = {
        enable = false;
        allowedTCPPorts = [
            6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
        ];
        allowedUDPPorts = [
            8472 # k3s, flannel: required if using multi-node for inter-node networking
        ];
    };
    services.k3s = {
        enable = true;
        token = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    };
    # disable swap for k8s cluster
    swapDevices = lib.mkForce [ ];
}