{
  lib,
  config,
  ...
}: let
  shellCfg = config.terminal.shell;
in {
  options.terminal.shell = {
    alises = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
    };
  };

  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases =
        {
          cd = "z";
          ls = "eza";
          cat = "bat";
          grep = "rg --color=auto";
        }
        // shellCfg.alises;

      initExtra = ''
        unsetopt BEEP
      '';

      history.size = 10000;
    };
  };
}
