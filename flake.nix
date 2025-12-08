{
  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nobbele/nixos-hardware";
  };

  outputs = inputs: let
    lib = inputs.nixpkgs.lib;
    hosts = import ./hosts;

    mkHomeConfiguration = {
      host,
      nixpkgs ? inputs.nixpkgs,
      home-manager ? inputs.home-manager,
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        extraSpecialArgs = {
          inherit host;
          inherit inputs;
          lib = inputs.nixpkgs.lib.extend (self: super:
            inputs.home-manager.lib
            // (import ./lib.nix {lib = self;}));
        };
        modules = [
          ./modules-home
          ./hosts/${host.dir}/home.nix
        ];
      };

    mkNixOSConfiguration = {
      host,
      nixpkgs ? inputs.nixpkgs,
    }:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit host;
          inherit inputs;
          lib = inputs.nixpkgs.lib.extend (self: super: (import ./lib.nix {lib = self;}));
        };
        modules = [
          ./modules-nixos
          ./hosts/${host.dir}/configuration.nix
          ./hosts/${host.dir}/configuration-hardware.nix
        ];
      };

    mkConfigurations = hosts: let
      hostMapper = {
        nixos ? false,
        home-manager ? false,
        ...
      } @ host:
        lib.attrsets.mergeAttrsList [
          (lib.attrsets.optionalAttrs nixos {
            nixosConfigurations.${host.hostname} = mkNixOSConfiguration {inherit host;};
          })
          (lib.attrsets.optionalAttrs home-manager {
            homeConfigurations."${host.username}@${host.hostname}" = mkHomeConfiguration {inherit host;};
          })
        ];

      recursiveMergeAttrsList = e: lib.foldl lib.attrsets.recursiveUpdate {} e;
    in
      recursiveMergeAttrsList (map hostMapper (lib.attrsets.attrValues hosts));
  in
    mkConfigurations hosts;
}
