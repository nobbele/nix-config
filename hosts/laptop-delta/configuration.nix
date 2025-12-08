{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-ideapad-14acn6
  ];
  # me.tools.container.enable = true;

  me.browser.enable = true;
  me.audio.lowLatency = true;
  me.ssh.server.enable = false;

  # TODO Make this prettier..
  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
    killall
    (inputs.nix-gaming.packages."${pkgs.stdenv.hostPlatform.system}".osu-lazer-bin.override {
      command_prefix = '''';
    })
  ];

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

  system.stateVersion = "24.05"; # Do not modify!!
}
