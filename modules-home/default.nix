{
  lib,
  host,
  inputs,
  ...
}: {
  imports = [
    ./gl.nix
    ./terminal
    ./apps
    ./dev
    ./plasma.nix
    ./xdg.nix
    ./cli
  ];

  options.me = {
    flakePath = lib.mkOpt' lib.types.path;
  };

  config = {
    home = {
      username = host.username;
      homeDirectory = "/home/${host.username}";
    };

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
