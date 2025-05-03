{ lib, pkgs, modulesPath, ... }:
{
  imports = [
    # This module installs the firmware
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  nix.settings = {
    # This is needed to allow building remotely
    trusted-users = [ "grant" ];

    # The nix-community cache has aarch64 builds of unfree packages,
    # which aren't in the normal cache
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  nixpkgs = {
    hostPlatform.system = "aarch64-linux";
    buildPlatform.system = "x86_64-linux";

    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };

  # These options make the sd card image build faster
  boot.supportedFilesystems.zfs = lib.mkForce false;
  sdImage.compressImage = false;

  networking = {
    # Set your hostname
    hostName = "pi-node";
    useNetworkd = true;
  };

  # Replace networkd with NetworkManager at your discretion
  systemd = {
    network = {
      enable = true;

      networks."10-lan" = {
        # This is the correct interface name on my raspi 4b
        matchConfig.Name = "end0";
        networkConfig.DHCP = "yes";
        linkConfig.RequiredForOnline = "routable";
      };
    };
  };

  # Add your username and ssh key
  users.users.grant = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILj262NWEDO459d3i6mOaMlhTXIQ3FN/PqfFciFlEXdd ruddickmg@gmail.com" ];
  };

  # Our user doesn't have a password, so we let them
  # do sudo without one
  security.sudo.wheelNeedsPassword = false;

  services = {
    openssh.enable = true;
    openssh.passwordAuthentication = false;
    openssh.challengeResponseAuthentication = false;
  };

  # Set your timezone
  time.timeZone = "Pacific/Honolulu";

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
    k3s
  ];

  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "24.11";
}
