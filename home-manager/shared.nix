{ pkgs, ... }:

{
  home.packages = with pkgs; [
    obsidian
    neovim
    aseprite
  ];
}