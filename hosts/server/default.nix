{ lib, pkgs, modulesPath, ... }:
{
    imports = [
      ../../configuration.nix
      ../../applications
    ];
    services.k3s.server.enable = true;
}