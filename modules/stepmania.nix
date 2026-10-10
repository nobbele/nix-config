{
  den.aspects.stepmania = {
    homeManager = { config, pkgs, ...}: {
      home.packages = with pkgs; [
        (itgmania.override {
          extraPackages = with itgmaniaPackages; [
            zmod-simply-love
          ];
        })
        outfox
      ];

      home.file.".project-outfox/Themes/XX--STARLiGHT--twopointzero".source = pkgs.fetchFromGitHub {
        owner = "MidflightDigital";
        repo = "XX--STARLiGHT--twopointzero";
        rev = "3c522eb";
        hash = "sha256-igoRq1fBiLalro8eP8ErLXFx/e/Qhc9YYjHoOagqOl0=";
      };

      home.file = {
        ".itgmania/Songs".source =
          config.lib.file.mkOutOfStoreSymlink
            "${config.home.homeDirectory}/StepMania/Songs";

        ".local/share/OutFox/Songs".source =
          config.lib.file.mkOutOfStoreSymlink
            "${config.home.homeDirectory}/StepMania/Songs";
      };

      home.activation.createSongsDir = config.lib.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p "${config.home.homeDirectory}/StepMania/Songs"
      '';
    };
  };
}