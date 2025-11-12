{
  config,
  pkgs,
  ...
}: {
  me.flakePath = config.home.homeDirectory + "/.nixos";
  me.fetch.distro = "nixos";
  me.dev.storm.enable = true;
  me.apps = {
    games.enable = true;
    creative.enable = true;
  };

  home.shellAliases = {
    # TODO hosts rewrite
    rb = "sudo nixos-rebuild switch --flake ${config.me.flakePath} -I ${config.me.flakePath}/nixos/configuration.nix --impure";
  };

  # TODO move this out into modules
  home.packages = with pkgs; [
    lutris
    wget
    git
    htop
    trash-cli
    gparted
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

  targets.genericLinux.enable = false;
  nixGL.defaultWrapper = "mesa";
  home.stateVersion = "24.11";
}
