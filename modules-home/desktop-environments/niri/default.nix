{
  config,
  pkgs,
  lib,
  ...
}: let
  selfCfg = config.me.desktop-environments.niri;
in {
  options.me.desktop-environments.niri = {
    enable = lib.mkEnableOpt;
  };

  config = lib.mkIf selfCfg.enable {
    home.packages = with pkgs; [
      alacritty
      fuzzel

      # Waybar
      waybar
      font-awesome_6
      adwaita-fonts

      # swaynotificationcenter
      (xwayland-satellite.override {withSystemd = false;}) # Niri automatically runs this when xwayland support is required
    ];

    programs.waybar = {
      enable = true;
    };

    xdg.configFile = {
      waybar.source = config.lib.file.mkOutOfStoreSymlink "${config.me.flakePath}/dotfiles/waybar";
      niri.source = config.lib.file.mkOutOfStoreSymlink "${config.me.flakePath}/dotfiles/niri";
    };
  };
}
