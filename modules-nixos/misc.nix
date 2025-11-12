{pkgs, ...}: {
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  services.flatpak.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      openssl
      stdenv.cc.cc.lib
    ];
  };
}
