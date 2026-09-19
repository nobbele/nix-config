{ ... }: {
  den.aspects.shell-replacements = {
    homeManager = {
      programs.bat.enable = true;
      programs.ripgrep = {
        enable = true;
        arguments = [
          "--color=auto"
        ];
      };
      programs.eza = {
        enable = true;
        colors = "auto";
      };
      programs.zoxide.enable = true;

      home.shellAliases = {
        cd = "z";
        ls = "eza";
        cat = "bat";
        grep = "rg";
      };
    };
  };
}