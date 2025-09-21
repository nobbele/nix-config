{ lib, config, pkgs, ... }:

let
  emacsCfg = config.custom.emacs;
in {
  options.custom.emacs = {
    enable = lib.mkEnableOption "emacs";
  };

  config = lib.mkIf emacsCfg.enable {
    home.file.".config/emacs".source = config.lib.file.mkOutOfStoreSymlink "${config.custom.flakePath}/dotfiles/emacs";

    home.packages = with pkgs; [
      emacs
    ];
  };
}