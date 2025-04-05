{ pkgs, ... }:

{
  home.glPackages = with pkgs; [
    obsidian
    neovim
    vesktop
    qbittorrent
    bitwarden-desktop
  ];
}
