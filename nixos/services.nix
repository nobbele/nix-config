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
