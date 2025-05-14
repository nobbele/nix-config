{ pkgs, lib, config, ... }:

let 
  helixCfg = config.custom.helix;
  inherit (config.lib) nixGL;
in 
{
  options.custom.helix = {
    enable = lib.mkEnableOption "helix";
  };

  config = lib.mkIf helixCfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      package = nixGL.wrap pkgs.helix;
      extraPackages = with pkgs; [ rustup ];
      settings = {
        theme = "transparent_catppuccin";
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
          soft-wrap.enable = true;
        };
      };
      themes = {
        transparent_catppuccin = {
          inherits = "catppuccin_macchiato";
          "ui.background" = { fg = ""; bg = ""; };
          "ui.statusline" = { fg = ""; bg = ""; };
        };
      };
      languages = {
        language-server = {
          rust-analyzer = { config = { cargo = { features = "all"; }; }; };
          nixd = { command = "nixd"; };
        };
        language = [{
          name = "nix";
          language-servers = [ "nixd" ];
        }];
      };
    };
  };
}