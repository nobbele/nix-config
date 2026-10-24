{
  den.aspects.stepmania = {
    homeManager = { config, pkgs, ...}: {
      home.packages = with pkgs; [
        (itgmania.override {
          extraPackages = with itgmaniaPackages; [
            zmod-simply-love
          ];
        })
      ];

      home.file = {
        ".itgmania/Songs".source =
          config.lib.file.mkOutOfStoreSymlink
            "${config.home.homeDirectory}/StepMania/Songs";
      };

      home.activation.createSongsDir = config.lib.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p "${config.home.homeDirectory}/StepMania/Songs"
      '';
    };
  };
}