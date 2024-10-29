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
    dotnetCorePackages.sdk_7_0
    nodejs
    # inputs.lemurs.packages."${system}".default
    libresprite
    # kitty
  ];
}
