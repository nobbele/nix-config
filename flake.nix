{
  outputs =
    inputs:
    (inputs.nixpkgs.lib.evalModules {
      modules = [ (inputs.import-tree ./modules) ];
      specialArgs = { inherit inputs; };
    }).config.flake;

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    import-tree.url = "github:vic/import-tree";
    den.url = "github:denful/den";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # dms = {
    #   url = "github:AvengeMedia/DankMaterialShell/stable";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
}
