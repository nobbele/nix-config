{
  lib,
  config,
  ...
}: let
  selfCfg = config.me.container;
in {
  options.me.container = {
    enable = lib.mkEnableOpt;
  };

  config = lib.mkIf selfCfg.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
