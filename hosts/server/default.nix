{ lib, pkgs, modulesPath, ... }:
{
    imports = [ ../configuration.nix ];
    services.k3s.server.enable = true;
}