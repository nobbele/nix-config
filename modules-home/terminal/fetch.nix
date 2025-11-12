{
  lib,
  pkgs,
  config,
  ...
}: let
  selfCfg = config.me.fetch;
  distroMap = {
    arch = "unicodearch";
    nixos = "nixos";
  };
in {
  options.me.fetch = {
    distro = lib.mkOpt' (lib.types.enum (builtins.attrNames distroMap));
  };

  config = {
    home.packages = [pkgs.fastfetch];

    xdg.configFile."fastfetch/config.jsonc".source =
      config.lib.file.mkOutOfStoreSymlink "${config.me.flakePath}/dotfiles/fastfetch.jsonc";

    me.terminal.initExtra = ''
      ${pkgs.hyfetch}/bin/hyfetch
    '';

    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "rainbow";
        mode = "rgb";
        color_align = {
          mode = "horizontal";
        };
        backend = "fastfetch";
        distro = distroMap.${selfCfg.distro};
        pride_month_disable = false;
      };
    };
  };
}
