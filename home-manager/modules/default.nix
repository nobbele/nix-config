{
  pkgs,
  config,
  ...
}:

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
    ./gl.nix
  ];

  config = {
    home.glPackages = with pkgs; [
      qimgv
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
