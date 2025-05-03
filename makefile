build:
  nix run nixpkgs#nixos-generators -- -f sd-aarch64 --flake .#server --system aarch64-linux -o ./pi.sd
