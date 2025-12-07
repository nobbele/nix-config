{ config, lib, pkgs, ... }:
{
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  me.browser.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  system.stateVersion = "25.11"; # Do not modify!!

}

