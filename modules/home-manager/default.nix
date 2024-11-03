{ pkgs, inputs, ... }:

{
  imports = [
    ./zsh.nix
    ./vscode.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "nobbele";
    homeDirectory = "/home/nobbele";
    packages = with pkgs; [
      bat
      ripgrep
      lsd
      inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
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