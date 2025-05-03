server:
  nix run nixpkgs#nixos-generators -- -f sd-aarch64 --flake .#server --system aarch64-linux -o ./server.sd

agent:
  nix run nixpkgs#nixos-generators -- -f sd-aarch64 --flake .#agent --system aarch64-linux -o ./agent.sd
