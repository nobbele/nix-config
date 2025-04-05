{
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
      withVSCode = true;
      isNixOS = true;
    };
    users = {
      nobbele = import ../home-manager/home.nix;
    };
  };
}
