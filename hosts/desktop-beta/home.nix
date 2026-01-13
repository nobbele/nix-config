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
