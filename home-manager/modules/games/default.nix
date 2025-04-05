{ pkgs, config, ... }:

let
  inherit (config.lib) nixGL;
in
{
  imports = [

  ];

  config = {
    home.packages = with pkgs; [
      (nixGL.wrap vintagestory)
    ];
  };
}
