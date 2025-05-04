server:
  nix run nixpkgs#nixos-generators -- -f sd-aarch64 --flake .#server --system aarch64-linux -o ./server.sd

agent-red:
  nix run nixpkgs#nixos-generators -- -f sd-aarch64 --flake .#agent-red --system aarch64-linux -o ./agent-red.sd

agent-green:
  nix run nixpkgs#nixos-generators -- -f sd-aarch64 --flake .#agent-green --system aarch64-linux -o ./agent-green.sd

agent-blue:
  nix run nixpkgs#nixos-generators -- -f sd-aarch64 --flake .#agent-blue --system aarch64-linux -o ./agent-blue.sd

clear-history:
  nix profile wipe-history

collect-garbage:
  nix-collect-garbage --delete-old

clear: clear-history collect-garbage
