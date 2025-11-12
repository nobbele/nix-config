{
  config,
  lib,
  ...
}: let
  selfCfg = config.me.ssh;
in {
  options.me.ssh = {
    server.enable = lib.mkEnableOpt;
  };

  config = lib.mkIf selfCfg.server.enable {
    services = {
      openssh = {
        enable = true;
        settings.PasswordAuthentication = false;
        settings.KbdInteractiveAuthentication = false;
      };
    };
  };
}
