{
  config,
  pkgs,
  ...
}: {
  me.flakePath = config.home.homeDirectory + "/.nixos";
  me.fetch.distro = "nixos";
  me.apps = {
    games.enable = true;
    vscode.enable = true;
    creative.enable = true;
  };

  home.shellAliases = {
    # TODO hosts rewrite
    rb = ''sudo nixos-rebuild switch --flake ${config.me.flakePath}#"$(hostname)" --impure "$@"'';
  };

  targets.genericLinux.enable = false;
  home.stateVersion = "25.11";
}
