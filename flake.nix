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

    # emacs-overlay = {
    #   url = "github:nix-community/emacs-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    # };

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];

    nixpkgs-overlays = import ./overlays {inherit inputs;};

    pkgsForSystem = system:
      import nixpkgs {
        overlays = builtins.attrValues nixpkgs-overlays;
        inherit system;
      };
  in {
    # legacyPackages = pkgsForSystem system;
    packages = forAllSystems (system: import ./pkgs (pkgsForSystem system));

    nixosConfigurations = let
      defaultSystem = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          (
            {...}: {
              nixpkgs.overlays = builtins.attrValues nixpkgs-overlays;
            }
          )
          ./nixos/configuration.nix
        ];
      };
    in {
      delta = defaultSystem.extendModules {
        modules = [./nixos/hosts/delta.nix];
      };
    };

    homeConfigurations."nobbele@delta" = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsForSystem "x86_64-linux";
      extraSpecialArgs = {
        inherit inputs outputs;
        isNixOS = true;
      };
      modules = [
        ./home-manager/home.nix
        ./home-manager/delta.nix
      ];
    };

    homeConfigurations."nobbele@beta" = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsForSystem "x86_64-linux";
      extraSpecialArgs = {
        inherit inputs outputs;
        isNixOS = false;
      };
      modules = [
        ./home-manager/home.nix
        ./home-manager/beta.nix
      ];
    };
  };
}
