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

    nixosConfigurations."agent-red" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        ./hosts/agent-red.nix
      ];
    };

    nixosConfigurations."agent-green" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        ./hosts/agent-green.nix
      ];
    };

    nixosConfigurations."agent-blue" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        ./hosts/agent-blue.nix
      ];
    };
  };
}
