{
  lib,
  host,
  inputs,
  ...
}: {
  imports = [
    ./terminal
    ./apps
    ./dev
    ./plasma.nix
    ./xdg.nix
    ./cli
    ./nvidia.nix
    (inputs.nix-index-database.homeModules.default)
  ];

  options.me = {
    flakePath = lib.mkOpt' lib.types.path;
  };

  config = {
    home = {
      username = host.username;
      homeDirectory = "/home/${host.username}";
    };

    programs.nix-index-database.comma.enable = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    nixpkgs.config.allowUnfree = true;

    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    programs.home-manager.enable = true;
  };
}
