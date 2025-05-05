{ lib, pkgs, modulesPath, ... }:
{
    imports = [
      ../configuration.nix
      ../authentication.nix
      ../applications
    ];
    services.tailscale.enable = true;
}