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
    home.packages = with pkgs; [
      (config.lib.nixGL.wrap reaper)
    ];
  };
}
