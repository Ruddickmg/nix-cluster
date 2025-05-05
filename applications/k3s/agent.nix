{ lib, pkgs, config, modulesPath, ... }:
{
    imports = [ ./common.nix ];
    config = lib.mkIf config.services.k3s.agent.enable {
        services.k3s = {
            role = "agent";
            serverAddr = "https://${config.services.k3s.host}:6443";
        };
    };
}