{ lib, pkgs, modulesPath, ... }:
{
    imports = [
      ../../configuration.nix
      ../../applications
    ];
    services.k3s.agent.enable = true;
}