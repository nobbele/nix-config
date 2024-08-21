{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: let
    defaultSystem = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./modules ];
      specialArgs = { inherit inputs; };
    };
  in {
    nixosConfigurations.delta = defaultSystem.extendModules {
      modules = [ ./hosts/delta.nix ];
    };
  };
}
