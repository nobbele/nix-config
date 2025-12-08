{...}: {
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  security.pam.services.sddm.enableKwallet = true;
}
