{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    # lemurs.url = "github:coastalwhite/lemurs";
  };

  outputs = { self, nixpkgs, ... }@inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";

    nixpkgs-overlays = import ./overlays { inherit inputs; };

    defaultSystem = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs; };
      modules = [
        ({ ... }: { nixpkgs.overlays = builtins.attrValues nixpkgs-overlays; })
        ./modules
      ];
    };

    pkgs = import nixpkgs { inherit system; overlays = builtins.attrValues nixpkgs-overlays; };
  in {
    packages.${system} = import ./pkgs pkgs;
    # packages.${system} = import ./pkgs nixpkgs.legacyPackages.${system};
    # overlays = import ./overlays { inherit inputs; };

    nixosConfigurations.delta = defaultSystem.extendModules {
      modules = [ ./hosts/delta.nix ];
    };
  };
}
