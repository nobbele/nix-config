{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    direnv.enable = true;
    firefox = {
      enable = true;
      package = pkgs.firefox-bin;

      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
    zsh.enable = true;
    gamemode.enable = true;

    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      openssl
      (runCommand "steamrun-lib" {} "mkdir $out; ln -s ${steam-run.fhsenv}/usr/lib64 $out/lib")
      stdenv.cc.cc.lib
    ];

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    hyprland = {
      enable = true;
      # xwayland.enable = true;

      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}
