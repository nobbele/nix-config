{ pkgs, config, ... }:

let
  inherit (config.lib) nixGL;
in
{
  imports = [
    ./plasma.nix
    ./terminal
    ./creative
    ./games
    ./xdg.nix
    ./development
  ];

  config = {
    home.packages = with pkgs; [
      (nixGL.wrap qimgv)
    ];

    programs.obs-studio = {
      enable = true;
      package = nixGL.wrap pkgs.obs-studio;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
      ];
    };
  };
}
