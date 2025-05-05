{ lib, pkgs, modulesPath, ... }:
{
    imports = [ ../configuration.nix ];
    services.k3s.agent.enable = true;
}