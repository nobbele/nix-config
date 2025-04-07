{pkgs, ...}: let
  flakePath = "/home/nobbele/.nixos";
in {
  nixGL.defaultWrapper = "mesa";

  terminal.shell.alises = {
    rb = "sudo nixos-rebuild switch --flake ${flakePath} -I ${flakePath}/nixos/configuration.nix --impure";
    rbh = "home-manager switch --flake ${flakePath}#$(whoami)@$(hostname) --impure";
  };

  custom.hyprland.enable = true;

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
    # unstable.kanata
    protonup-qt

    # Dev
    rustup
    # (unstable.jetbrains.rider.overrideAttrs (attrs: {
    #   postInstall =
    #     (attrs.postInstall or "")
    #     + lib.optionalString (stdenv.hostPlatform.isLinux) ''
    #       (
    #         cd $out/rider

    #         for dir in lib/ReSharperHost/linux-*; do
    #           rm -rf $dir/dotnet
    #           ln -s ${dotnetCorePackages.sdk_8_0} $dir/dotnet
    #         done
    #       )
    #     '';
    # }))

    # Games
    winetricks
    corefonts
    wineWowPackages.staging
    # unstable.itgmania
  ];
}
