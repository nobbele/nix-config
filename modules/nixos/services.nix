{ ... }:

{
  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
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

    # openssh.enable = true;
    flatpak.enable = true;
  };

  # security.rtkit.enable = true;
}