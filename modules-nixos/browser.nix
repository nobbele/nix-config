{
  config,
  lib,
  ...
}: let
  selfCfg = config.me.browser;
in {
  options.me.browser = {
    enable = lib.mkEnableOpt;
  };

  config = lib.mkIf selfCfg.enable {
    programs.firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
  };
}
