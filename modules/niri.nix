{ inputs, ... }: {
  den.aspects.niri = {
    nixos = { pkgs, ... }: {
      programs.niri.enable = true;
      programs.dms-shell = {
        enable = true;

        systemd = {
          enable = true;
          restartIfChanged = true;
        };

        # enableSystemMonitoring = true;
        # enableVPN = true;
        # enableDynamicTheming = true;
        # enableAudioWavelength = true;  
        # enableCalendarEvents = true;   
      };

      systemd.user.services.niri.wants = [ "dms.service" ];

      environment.systemPackages = with pkgs; [
        brightnessctl
        fuzzel
        foot
      ];
    };
  };
}
