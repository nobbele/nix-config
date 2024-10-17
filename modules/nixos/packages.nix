{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    htop
    trash-cli
    gparted
    mpv
    clang
    gcc
    gnumake
    openssl
    distrobox
    cmake
    dotnet-sdk
  ];
}