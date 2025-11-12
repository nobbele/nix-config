{
  lib,
  config,
  pkgs,
  ...
}: let
  emacsCfg = config.me.apps.emacs;
in {
  options.me.apps.emacs = {
    enable = lib.mkEnableOpt;
  };

  config = lib.mkIf emacsCfg.enable {
    home.file.".config/emacs".source = config.lib.file.mkOutOfStoreSymlink "${config.me.flakePath}/dotfiles/emacs";

    me.terminal.initExtra = ''
      [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
        source "$EAT_SHELL_INTEGRATION_DIR/zsh"
    '';

    home.packages = with pkgs; [
      emacs
    ];
  };
}
