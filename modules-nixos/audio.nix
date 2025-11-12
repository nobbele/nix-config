{
  config,
  lib,
  ...
}: let
  selfCfg = config.me.audio;
in {
  options.me.audio = {
    lowLatency = lib.mkEnableOpt;
  };

  config = {
    services.pipewire =
      {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      }
      // lib.mkIf selfCfg.lowLatency {
        extraConfig.pipewire."92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.min-quantum" = 256;
          };
        };

        extraConfig.pipewire-pulse."92-low-latency" = {
          context.modules = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = {
                pulse.min.req = "128/48000";
                pulse.min.quantum = "128/48000";
              };
            }
          ];
          stream.properties = {
            node.latency = "128/48000";
          };
        };
      };
  };
}
