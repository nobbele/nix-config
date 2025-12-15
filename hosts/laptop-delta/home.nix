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
    vscode.enable = true;
    creative.enable = true;
  };

  home.shellAliases = {
    # TODO refer to special argument "host"
    rb = ''sudo nixos-rebuild switch --flake ${config.me.flakePath}#"$(hostname)" --impure "$@"'';
  };

  # TODO move this out into modules
  home.packages = with pkgs; [
    lutris
    clang
    gnumake
    openssl
    cmake
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
  home.stateVersion = "24.11";
}
