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
  config = lib.mkIf (terminalCfg.emulator == "wezterm") {
    programs.wezterm = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.wezterm;
      enableZshIntegration = true;
    };
  };
}
