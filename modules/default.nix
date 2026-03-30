{den, ...}: {
  den.default = {
    includes = [
      den.provides.define-user
      den.provides.hostname
    ];

    # TODO install portal?
    nixos = {pkgs, ...}: {
      documentation.doc.enable = false;
      documentation.info.enable = false;

      networking.networkmanager.enable = true;
      services.automatic-timezoned.enable = true;

      services.flatpak.enable = true;

      environment.systemPackages = with pkgs; [
        git
        wget
        trash-cli
        distrobox
      ];

      environment.sessionVariables = {
        # Firefox smooth scroll
        MOZ_USE_XINPUT2 = "1";
      };
    };
  };
}
