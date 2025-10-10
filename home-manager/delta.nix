{pkgs, ...}: let
  flakePath = "/home/nobbele/.nixos";
in {
  nixGL.defaultWrapper = "mesa";

  custom.flakePath = flakePath;

  terminal.shell.alises = {
    rb = "sudo nixos-rebuild switch --flake ${flakePath} -I ${flakePath}/nixos/configuration.nix --impure";
    rbh = "home-manager switch --flake ${flakePath}#$(whoami)@$(hostname) --impure";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  # custom.hyprland.enable = false;
  # wayland.windowManager.hyprland.package = null;
  # wayland.windowManager.hyprland.portalPackage = null;

  home.packages = with pkgs; [
    lutris
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
    cheese
    protonup-qt

    # Dev
    rustup
    devenv
    docker-compose
    godot-mono

    nerd-fonts.jetbrains-mono

    # Games
    winetricks
    corefonts
    wineWowPackages.staging
    # unstable.itgmania

    spotify
    vesktop

    onlyoffice-desktopeditors
  ];
}
