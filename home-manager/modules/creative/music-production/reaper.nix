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
  config = lib.mkIf (creativeCfg.daw == "reaper") {
    home.glPackages = with pkgs; [ reaper ];
  };
}
