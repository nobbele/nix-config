{ lib, config, pkgs, inputs, ... }:

let 
  # inherit (config.lib) nixGL;
  emacsCfg = config.custom.emacs;
  /*emacs-stable = (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (epkgs: with epkgs; [
    treesit-grammars.with-all-grammars
    # vterm
    # mu4e
    # dune
  ]);*/
  emacs = with pkgs; (emacsPackagesFor pkgs.emacs-git-pgtk).emacsWithPackages (epkgs: with epkgs; [
    treesit-grammars.with-all-grammars
    vterm
  ]);
in {
  options.custom.emacs = {
    enable = lib.mkEnableOption "emacs";
  };

  config = lib.mkIf emacsCfg.enable {
    home.file = {
      ".config/doom" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.custom.flakePath}/dotfiles/doom";
      };  
    };

    nixpkgs.overlays = [
      inputs.emacs-overlay.overlays.default
    ];

    services.emacs = {
      enable = true;
      package = emacs;
    };

    home.packages = with pkgs; [
      emacs
      ripgrep

      coreutils # basic GNU utilities
      fd
      clang

      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :lang cc
      clang-tools
      # :lang nix
      age
    ];

    /*environment.systemPackages = with pkgs; [
      ## Emacs itself
      binutils            # native-comp needs 'as', provided by this
      emacs-stable               # HEAD + native-comp

      ## Doom dependencies
      git
      ripgrep
      gnutls              # for TLS connectivity

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
      (mkIf (config.programs.gnupg.agent.enable)
        pinentry-emacs)   # in-emacs gnupg prompts
      zstd                # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :email mu4e
      mu
      unstable.isync
      # :checkers spell
      (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
      # :lang beancount
      beancount
      fava
      # :lang nix
      age
    ];*/

    home.sessionPath = [ "$XDG_CONFIG_HOME/emacs/bin" ];
  };
}