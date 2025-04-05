{
  config,
  lib,
  ...
}:

let
  terminalCfg = config.terminal;
in
{
  config = lib.mkIf (terminalCfg.prompt == "starship") {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = lib.importTOML ./starship.toml;
    };
  };
}
