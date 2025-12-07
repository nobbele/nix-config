{pkgs, ...}: {
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    htop
    trash-cli
    gparted
    distrobox
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      openssl
      stdenv.cc.cc.lib
    ];
  };
}
