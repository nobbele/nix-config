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
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixgl, ...} @ inputs: let
    hosts = import ./hosts;

    mkHomeConfigurations = {
      host,
      nixpkgs,
      home-manager,
      modules ? [],
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [nixgl.overlay];
          config = {
            allowUnfree = true;
          };
        };
        extraSpecialArgs = {
          inherit host;
          inherit inputs;
          lib = inputs.nixpkgs.lib.extend (self: super:
            inputs.home-manager.lib
            // (import ./lib.nix {lib = self;}));
        };
        modules =
          [
            ./modules-home
            ./hosts/${host.dir}/home.nix
            # ./overlays
          ]
          ++ modules;
      };
  in {
    # legacyPackages = pkgsForSystem system;
    # packages = forAllSystems (system: import ./pkgs (pkgsForSystem system));

    # nixosConfigurations = let
    #   defaultSystem = nixpkgs.lib.nixosSystem {
    #     specialArgs = {inherit inputs outputs;};
    #     modules = [
    #       (
    #         {...}: {
    #           nixpkgs.overlays = builtins.attrValues nixpkgs-overlays;
    #         }
    #       )
    #       ./nixos/configuration.nix
    #     ];
    #   };
    # in {
    #   delta = defaultSystem.extendModules {
    #     modules = [./nixos/hosts/delta.nix];
    #   };
    # };

    # homeConfigurations."nobbele@delta" = home-manager.lib.homeManagerConfiguration {
    #   pkgs = pkgsForSystem "x86_64-linux";
    #   extraSpecialArgs = {
    #     inherit inputs outputs;
    #     isNixOS = true;
    #   };
    #   modules = [
    #     ./home-manager/home.nix
    #     ./home-manager/delta.nix
    #   ];
    # };

    homeConfigurations."${hosts.desktop-beta.username}@${hosts.desktop-beta.hostname}" = mkHomeConfigurations {
      host = hosts.desktop-beta;
      nixpkgs = inputs.nixpkgs;
      home-manager = inputs.home-manager;
    };
  };
}
