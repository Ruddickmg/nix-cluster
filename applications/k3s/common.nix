{ lib, pkgs, config, modulesPath, ... }:
{
    options.services.k3s = {
        agent.enable = lib.mkEnableOption "Enable k3s agent";
        server.enable = lib.mkEnableOption "Enable k3s agent";
        host = lib.mkOption {
            type = lib.types.str;
            default = "192.168.0.153";
        };
    };
    config = lib.mkIf (config.services.k3s.server.enable || config.services.k3s.agent.enable) {
        environment.systemPackages = with pkgs; [
            k3s
        ];
        networking.firewall = {
            allowedTCPPorts = [
                6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
                10250 # Kubelet metrics
                # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
                # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
            ];
            allowedUDPPorts = [
                8472 # k3s, flannel: required if using multi-node for inter-node networking
                51820 # Required for Flannel Wireguard with IPv4
                # 51821 # Required for Flannel Wireguard with IPv6
            ];
        };
        services.k3s = {
            enable = true;
        };
        # disable swap for k8s cluster
        swapDevices = lib.mkForce [ ];
    };
}
