{
  pkgs,
  config,
  ...
}: let
  inherit (config.lib) nixGL;
in {
  home.glPackages = with pkgs; [
    obsidian
    qbittorrent
    bitwarden-desktop
    qimgv
    xorg.xeyes
    # teamspeak6-client
  ];

  home.packages = with pkgs; [
    storm-lang
    mymake
  ];

  programs.obs-studio = {
    enable = true;
    package = nixGL.wrap pkgs.obs-studio;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
    ];
  };

  programs.neovim = {
    enable = true;
    package = nixGL.wrap pkgs.neovim-unwrapped;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.direnv = {
    enable = true;
  };
}
