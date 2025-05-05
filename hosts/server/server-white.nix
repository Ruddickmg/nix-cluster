{ lib, pkgs, modulesPath, ... }:
{
    imports = [
      ./default.nix
    ];
    networking.hostName = "server-white";
}