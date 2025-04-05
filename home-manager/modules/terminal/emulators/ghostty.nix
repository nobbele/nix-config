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
  config = lib.mkIf (terminalCfg.emulator == "ghostty") {
    programs.ghostty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.ghostty;
      enableZshIntegration = true;
      settings = {
        command = "${pkgs.zsh}/bin/zsh";
      };
    };
  };
}
