{
  description = "my flake setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: rec {

    nixosConfigurations."server-white" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [ ./hosts/server/server-white.nix ];
    };

    nixosConfigurations."agent-red" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [ ./hosts/agent/agent-red.nix ];
    };

    nixosConfigurations."agent-green" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [ ./hosts/agent/agent-green.nix ];
    };

    nixosConfigurations."agent-blue" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [ ./hosts/agent/agent-blue.nix ];
    };
  };
}
