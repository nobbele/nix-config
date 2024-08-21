{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    htop
    trash-cli
  ];
}