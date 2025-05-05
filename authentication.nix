{ config, lib, pkgs, ... }:
{
    services.tailscale.authKey = "tskey-fill-me-in";
    services.k3s.token = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
}
