{
  config,
  ...
}: {
  config = {
    programs.vscode = {
      enable = true;
    };

    home.activation.makeVSCodeConfigWritable = let
      configDirName =
        {
          "vscode" = "Code";
          "vscode-insiders" = "Code - Insiders";
          "vscodium" = "VSCodium";
        }
        .${config.programs.vscode.package.pname};
      configPath = "${config.xdg.configHome}/${configDirName}/User/settings.json";
    in {
      after = ["writeBoundary"];
      before = [];
      data = ''
        echo ${configPath}
        echo $(readlink ${configPath})
        install -m 0640 "$(readlink ${configPath})" ${configPath}
      '';
    };
  };
}
