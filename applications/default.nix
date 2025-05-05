{ lib, pkgs, modulesPath, ... }:
{
    imports = [
        ./k3s
        ./tailscale
    ];
}