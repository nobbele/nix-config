{
  lib,
  pkgs,
  config,
  ...
}: let
  selfCfg = config.me.apps.games;
in {
  options.me.apps.games = {
    enable = lib.mkEnableOpt;
    extraEnable = lib.mkEnableOpt;
  };

  config = lib.mkIf selfCfg.enable {
    home.glPackages = with pkgs; [
      prismlauncher
    ];
  };
}
