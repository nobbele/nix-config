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
    nixpkgs-overlays = {
      overlay-unstable = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
          config.permittedInsecurePackages = [
            "dotnet-sdk-6.0.428"
          ];
        };
      };
    };

    defaultSystem = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ ... }: { nixpkgs.overlays = builtins.attrValues nixpkgs-overlays; })
        ./modules
      ];
      specialArgs = { inherit inputs; };
    };
  in {
    nixosConfigurations.delta = defaultSystem.extendModules {
      modules = [ ./hosts/delta.nix ];
    };
  };
}
