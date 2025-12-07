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
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = inputs: let
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
  in {
    nixosConfigurations.${hosts.laptop-delta.hostname} = mkNixOSConfiguration {
      host = hosts.laptop-delta;
    };
    nixosConfigurations.${hosts.laptop-gamma.hostname} = mkNixOSConfiguration {
      host = hosts.laptop-gamma;
    };

    homeConfigurations."${hosts.laptop-delta.username}@${hosts.laptop-delta.hostname}" = mkHomeConfiguration {
      host = hosts.laptop-delta;
    };
    homeConfigurations."${hosts.desktop-beta.username}@${hosts.desktop-beta.hostname}" = mkHomeConfiguration {
      host = hosts.desktop-beta;
    };
    homeConfigurations."${hosts.laptop-gamma.username}@${hosts.laptop-gamma.hostname}" = mkHomeConfiguration {
      host = hosts.laptop-gamma;
    };
  };
}
