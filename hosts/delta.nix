{ ... }:

{
  imports = [
    ./delta-hardware.nix
  ];

  networking.hostName = "delta";

  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
       governor = "powersave";
       turbo = "never";
    };
    charger = {
       governor = "performance";
       turbo = "auto";
    };
  };
}