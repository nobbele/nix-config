{den, ...}: {
  den.hosts.x86_64-linux.delta.users.nobbele = {};

  den.aspects.delta = {
    includes = [
      den.aspects.gaming
      # den.aspects.ssh-server
    ];
    nixos = {inputs, ...}: {
      imports = [
        ./_hardware.nix
        inputs.nixos-hardware.nixosModules.lenovo-ideapad-14acn6
      ];

      hardware.bluetooth.enable = true;

      networking.networkmanager.wifi.powersave = false;
      hardware.enableRedistributableFirmware = true;
      boot.kernelParams = ["pcie_aspm=off"];

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

      system.stateVersion = "24.05"; # Do not modify!!
    };
  };
}
