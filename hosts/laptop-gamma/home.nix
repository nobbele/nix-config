{
  config,
  pkgs,
  ...
}: {
  me.flakePath = config.home.homeDirectory + "/.nixos";
  me.fetch.distro = "nixos";
  me.apps = {
    vscode.enable = true;
  };

  home.shellAliases = {
    # TODO hosts rewrite
    rb = ''sudo nixos-rebuild switch --flake ${config.me.flakePath}#"$(hostname)" --impure "$@"'';
  };

  home.packages = with pkgs; [
    onlyoffice-desktopeditors
  ];

  targets.genericLinux.enable = false;
  home.stateVersion = "25.11";
}
