{
  lib,
  config,
  ...
}: let
  selfCfg = config.me.hardware.yubikey;
in {
  options.me.hardware.yubikey = {
    enable = lib.mkEnableOpt;
  };

  config = lib.mkIf selfCfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      settings = {
        default-cache-ttl = 3600;
        max-cache-ttl = 999999;
      };
    };
  };
}
