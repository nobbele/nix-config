{
  config,
  pkgs,
  ...
}: {
  me.flakePath = config.home.homeDirectory + "/nix-config";
  me.fetch.distro = "arch";
  me.nvidia.enable = true;
  me.dev.storm.enable = true;
  me.apps = {
    games.enable = true;
    games.extraEnable = true;
    vscode.enable = true;
    creative.enable = true;
  };

  programs.gpg = {
    enable = true;
  };

  # TODO Move gpg-agent into a hm module and share it with the other computers.
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    defaultCacheTtl = 3600;
    maxCacheTtl = 999999;
    pinentry.package = pkgs.pinentry-qt;
  };

  # I think this is unncessary? services.gpg-agent should already set it
  home.sessionVariables = {
    SSH_AUTH_SOCK = "$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)";
  };

  # I think this is unncessary? services.gpg-agent should already set it
  programs.zsh.initExtra = ''
    export SSH_AUTH_SOCK="$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)"
  '';

  home.packages = with pkgs; [
    # More stable than installing it from the AUR :P
    paru
  ];

  home.sessionPath = [
    "/opt/outfox/"
  ];

  targets.genericLinux.enable = true;
  home.stateVersion = "24.11";
}
