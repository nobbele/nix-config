{pkgs, ...}: {
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    # Nix packages configure Chrome and Electron apps to run in native Wayland if this is set.
    NIXOS_OZONE_WL = "1";
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    htop
    trash-cli
    gparted
    distrobox
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      openssl
      stdenv.cc.cc.lib
    ];
  };
}
