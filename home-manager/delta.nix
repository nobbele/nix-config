{ pkgs, ... }:

let
  flakePath = "/home/nobbele/.nixos";
in
{
  nixGL.defaultWrapper = "mesa";

  terminal.shell.alises = {
    rb = "sudo nixos-rebuild switch --flake ${flakePath} -I ${flakePath}/nixos/configuration.nix --impure";
    rbh = "home-manager switch --flake ${flakePath}#$(whoami)@$(hostname) --impure";
  };

  development.vscode.enabled = true;

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
    (with dotnetCorePackages; combinePackages [
      sdk_7_0
      sdk_8_0
    ])
    nodejs
    icu
    pkg-config
    unrar

    # User programs.
    bitwarden-desktop
    discord-canary
    macchina
    google-chrome
    anki-bin
    qemu_full
    webcord
    vesktop
    unstable.qbittorrent
    # inputs.zen-browser.packages."${system}".specific
    cheese
    unstable.kanata
    inkscape
    libreoffice-qt
    protonup-qt

    # Dev
    nil
    rustup
    tokei
    eigen
    (unstable.jetbrains.rider.overrideAttrs (attrs: {
      postInstall =
        (attrs.postInstall or "")
        + lib.optionalString (stdenv.hostPlatform.isLinux) ''
          (
            cd $out/rider

            for dir in lib/ReSharperHost/linux-*; do
              rm -rf $dir/dotnet
              ln -s ${dotnetCorePackages.sdk_8_0} $dir/dotnet
            done
          )
        '';
    }))

    # Games
    lutris
    prismlauncher
    winetricks
    corefonts
    wineWowPackages.staging
    unstable.itgmania

    # Game Dev
    # unstable.godot_4-mono
    unityhub

    # Music Production
    unstable.famistudio
    bambootracker
    furnace
    reaper
    yabridge
    yabridgectl
  ];
}
