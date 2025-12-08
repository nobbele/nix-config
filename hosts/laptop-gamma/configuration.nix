{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.hp-elitebook-AY4Z7AV
  ];

  me.browser.enable = true;
  me.hardware.yubikey.enable = true;

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
