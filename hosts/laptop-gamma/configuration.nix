{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  me.browser.enable = true;

  security.pam.services.sddm.enableKwallet = true;

  environment.systemPackages = [
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  boot = {
    initrd.systemd.enable = true;
    loader.timeout = 0;

    plymouth = {
      enable = true;
      theme = "bgrt";
    };
  };

  # Hardware (TODO Upstream to nixos-hardware)
  hardware.enableRedistributableFirmware = lib.mkDefault true;
  services.thermald.enable = lib.mkDefault true;
  services.fwupd.enable = lib.mkDefault true;
  boot.kernelModules = ["hp-wmi"];
  hardware.enableAllFirmware = lib.mkDefault true;
  networking.networkmanager.settings.device = {
    "wifi.scan-rand-mac-address" = "no";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  hardware.bluetooth.enable = true;

  system.stateVersion = "25.11"; # Do not modify!!
}
