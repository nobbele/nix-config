{...}: {
  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    # displayManager.enable = true;
    # lemurs.enable = true;
    # xserver.displayManager.lightdm.enable = false;
    desktopManager.plasma6.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      # jack.enable = true;
      wireplumber.enable = true;

      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          # "default.clock.quantum" = 128;
          "default.clock.min-quantum" = 256;
          # "default.clock.max-quantum" = 64;
        };
      };

      extraConfig.pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "128/48000";
              # pulse.default.req = "32/48000";
              # pulse.max.req = "32/48000";
              pulse.min.quantum = "128/48000";
              # pulse.max.quantum = "32/48000";
            };
          }
        ];
        stream.properties = {
          node.latency = "128/48000";
          # resample.quality = 1;
        };
      };

      # lowLatency = {
      #   enable = true;
      #   quantum = 64;
      #   rate = 48000;
      # };
    };

    libinput.enable = true;
    automatic-timezoned.enable = true;

    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };

    # openssh.enable = true;
    flatpak.enable = true;
    lorri.enable = true;
  };

  # security.rtkit.enable = true;
}
