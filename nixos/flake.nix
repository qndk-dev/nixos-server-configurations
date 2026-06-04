{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, sops-nix }: {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        sops-nix.nixosModules.sops
        ./hosts/main/configuration.nix
        ./hosts/main/hardware-configuration.nix
        ./modules/common.nix
        ./modules/wireguard.nix
        ./modules/postgresql.nix
      ];
    };
  };
}