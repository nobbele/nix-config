{
  config,
  pkgs,
  lib,
  ...
}:

let
  terminalCfg = config.terminal;
in
{
  config = lib.mkIf (terminalCfg.emulator == "kitty") {
    programs.kitty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.kitty;
      shellIntegration.enableZshIntegration = true;
    };
  };
}
