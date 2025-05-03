{
  description = "my flake setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: rec {

    nixosConfigurations."server" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        ./k3s/server.nix
      ];
    };

    nixosConfigurations."agent" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        ./k3s/agent.nix
      ];
    };
  };
}
