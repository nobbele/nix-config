{
  config,
  pkgs,
  lib,
  ...
}: let
  terminalCfg = config.terminal;
in {
  config = lib.mkIf (terminalCfg.emulator == "foot") {
    programs.foot = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.foot;
      server.enable = true;
    };
  };
}
