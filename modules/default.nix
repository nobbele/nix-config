{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ./nixos
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      nobbele = import ./home-manager;
    };
  };
}