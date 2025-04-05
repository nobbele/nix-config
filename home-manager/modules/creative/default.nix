{ pkgs, config, ... }:

let
  inherit (config.lib) nixGL;
in
{
  imports = [
    ./music-production
  ];

  config = {
    home.packages = with pkgs; [
      (nixGL.wrap blender)
      (nixGL.wrap gimp)
      (nixGL.wrap krita)
      (nixGL.wrap libresprite)
      (nixGL.wrap kdePackages.kdenlive)
    ];
  };
}
