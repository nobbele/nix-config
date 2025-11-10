{pkgs, config, ...}:
{
  home.packages = [ pkgs.fastfetch ];
  xdg = let 
    fastfetchConfigSrc = config.lib.file.mkOutOfStoreSymlink "${config.custom.flakePath}/dotfiles/fastfetch.jsonc";
  in {
    configFile."fastfetch/config.jsonc".source = fastfetchConfigSrc;
  };

  programs.hyfetch = {
    enable =  true;
    settings = {
      preset = "rainbow";
      mode = "rgb";
      color_align = {
        mode = "horizontal";
      };
      backend = "fastfetch";
      pride_month_disable = false;
    };
  };
}