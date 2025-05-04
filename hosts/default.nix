{ lib, pkgs, modulesPath, ... }:
{
    imports = [
      ../k3s/agent.nix
    ];
    networking.hostName = "agent-node";
}