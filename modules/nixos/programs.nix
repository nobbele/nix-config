{ pkgs, ... }:

{
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
    ];

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}