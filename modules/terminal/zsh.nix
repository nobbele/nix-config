{ den, lib, ... }: {
  den.aspects.zsh = {
    includes = [
      (den.batteries.user-shell "zsh")
    ];

    homeManager = {
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
        '';

        history.size = 10000;
      };

      programs.starship = {
        enable = true;
        settings = lib.importTOML ./starship.toml;
      };
    };
  };
}