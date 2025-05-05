{ lib, pkgs, modulesPath, ... }:
{
    imports = [
      ../../configuration.nix
      ../../applications
    ];
    services.k3s.server.enable = true;
    services.tailscale = {
        authKey = "";
        enable = true;
    };
}