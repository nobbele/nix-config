{
  config,
  host,
  lib,
  ...
}: let
  selfCfg = config.me.apps.vscode;

  hostSettings = config.lib.file.mkOutOfStoreSymlink "${config.me.flakePath}/_old/dotfiles/${host.dir}/vscode-settings.json";
  vscodeDir = builtins.getAttr (config.programs.vscode.package.pname) {
    "vscode" = "Code";
    "vscode-insiders" = "Code - Insiders";
    "vscodium" = "VSCodium";
  };
in {
  options.me.apps.vscode = {
    enable = lib.mkEnableOpt;
  };

  config = lib.mkIf selfCfg.enable {
    programs.vscode = {
      enable = true;
    };

    home.file.".config/${vscodeDir}/User/settings.json".source = hostSettings;
  };
}
