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
    home.glPackages = with pkgs; [ lmms ];
  };
}
