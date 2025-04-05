{
  pkgs,
  config,
  ...
}: let
  inherit (config.lib) nixGL;
in {
  home.glPackages = with pkgs; [
    obsidian
    neovim
    vesktop
    qbittorrent
    bitwarden-desktop
    qimgv
  ];

  programs.obs-studio = {
    enable = true;
    package = nixGL.wrap pkgs.obs-studio;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
    ];
  };
}
