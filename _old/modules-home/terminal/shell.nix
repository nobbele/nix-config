{
  config,
  lib,
  ...
}: let
  selfCfg = config.me.terminal;
in {
  options.me.terminal = {
    aliases = lib.mkOpt (lib.types.attrsOf lib.types.str) {};
    initExtra = lib.mkOpt' lib.types.lines;
  };

  config = {
    home.shell.enableZshIntegration = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        unsetopt BEEP

        bindkey  "^[[H"   beginning-of-line
        bindkey  "^[[F"   end-of-line
        bindkey  "^[[3~"  delete-char

        ${selfCfg.initExtra}
      '';

      history.size = 10000;
    };
  };
}
