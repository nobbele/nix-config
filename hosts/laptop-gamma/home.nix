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
    # TODO refer to special argument "host"
    rb = ''sudo nixos-rebuild switch --flake ${config.me.flakePath}#"$(hostname)" --impure "$@"'';
  };

  home.packages = with pkgs; [
    onlyoffice-desktopeditors

    # ad-tools
    (pkgs.python3.withPackages (python-pkgs:
      with python-pkgs; [
        ldap3
        gssapi
        cryptography
      ]))
    krb5.dev
    krb5
    gcc

    # Deb Diffing
    debian-devscripts
    wdiff
  ];

  targets.genericLinux.enable = false;
  home.stateVersion = "25.11";
}
