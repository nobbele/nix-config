{config, ...}: {
  imports = [
    ./delta-hardware.nix
  ];

  networking.hostName = "delta";

  powerManagement.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      # START_CHARGE_THRESH_BAT1 = 40;
      STOP_CHARGE_THRESH_BAT1 = 85;
    };
  };

  hardware.bluetooth.enable = true;
  # hardware.bluetooth = {
  #   settings.General = {
  #     experimental = true; # show battery

  #     # https://www.reddit.com/r/NixOS/comments/1ch5d2p/comment/lkbabax/
  #     # for pairing bluetooth controller
  #     Privacy = "device";
  #     JustWorksRepairing = "always";
  #     Class = "0x000100";
  #     FastConnectable = true;
  #   };
  # };

  # services.blueman.enable = true;
  # hardware.xpadneo.enable = true; # Enable the xpadneo driver for Xbox One wireless controllers

  # boot = {
  #   extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
  #   extraModprobeConfig = ''
  #     options bluetooth disable_ertm=Y
  #   '';
  #   # connect xbox controller
  # };
}
