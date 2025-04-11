{pkgs, ...}: let
  flakePath = "/home/nobbele/.nixos";
in {
  nixGL.defaultWrapper = "mesa";

  terminal.shell.alises = {
    rb = "sudo nixos-rebuild switch --flake ${flakePath} -I ${flakePath}/nixos/configuration.nix --impure";
    rbh = "home-manager switch --flake ${flakePath}#$(whoami)@$(hostname) --impure";
  };

  custom.hyprland.enable = false;
  # wayland.windowManager.hyprland.package = null;
  # wayland.windowManager.hyprland.portalPackage = null;

  home.packages = with pkgs; [
    wget
    git
    htop
    trash-cli
    gparted
    mpv
    clang
    gnumake
    openssl
    distrobox
    cmake
    (
      with dotnetCorePackages;
        combinePackages [
          sdk_7_0
          sdk_8_0
        ]
    )
    nodejs
    icu
    pkg-config
    unrar

    # User programs.
    macchina
    cheese
    protonup-qt

    # Dev
    rustup

    nerd-fonts.jetbrains-mono

    # Games
    winetricks
    corefonts
    wineWowPackages.staging
    # unstable.itgmania
  ];
}
