{
  config,
  pkgs,
  ...
}: {
  imports = [./storm.nix ./dotnet.nix];

  config = {
    home.packages = with pkgs; [
      omnisharp-roslyn
      devenv
      tokei
      nixd
      alejandra
    ];

    programs.direnv = {
      enable = true;
    };

    programs.neovim = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.neovim-unwrapped;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
