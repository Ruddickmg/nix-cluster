{ lib, pkgs, modulesPath, ... }:
{
    imports = [
      ./default.nix
    ];
    networking.hostName = "agent-green";
}