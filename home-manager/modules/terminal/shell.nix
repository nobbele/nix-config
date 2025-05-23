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
    home.shell.enableZshIntegration = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = shellCfg.alises;

      initContent = ''
        unsetopt BEEP

        bindkey  "^[[H"   beginning-of-line
        bindkey  "^[[F"   end-of-line
        bindkey  "^[[3~"  delete-char
      '';

      history.size = 10000;
    };
  };
}
