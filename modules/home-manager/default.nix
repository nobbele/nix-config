{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
  ];

  home = {
    username = "nobbele";
    homeDirectory = "/home/nobbele";
    packages = with pkgs; [
      bat
      ripgrep
      lsd
    ];
  };

  programs = {
    zoxide.enable = true;
    bat.enable = true;
    ripgrep.enable = true;
    lsd.enable = true;
  };

  home.stateVersion = "24.05"; # Do not modify!!
}