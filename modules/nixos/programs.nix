{ pkgs, ... }:

{
  programs = {
    direnv.enable = true;
    firefox = {
      enable = true;
      package = pkgs.firefox-bin;

      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
    zsh.enable = true;
  };
}