{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ./nixos
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "hm-bak";
    users = {
      nobbele = import ./home-manager;
    };
  };
}