{
  config,
  pkgs,
  lib,
  ...
}:

let
  creativeCfg = config.creative;
in
{
  config = lib.mkIf (creativeCfg.daw == "lmms") {
    home.packages = with pkgs; [
      (config.lib.nixGL.wrap lmms)
    ];
  };
}
