{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.system}.default
    killall
    # inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    (inputs.nix-gaming.packages."${system}".osu-lazer-bin.override {
      command_prefix = '''';
      # command_prefix = ''
        # env PIPEWIRE_LATENCY="128/48000" OSU_SDL3=0 __GL_THREADED_OPTIMIZATIONS=0 PIPEWIRE_ALSA="{ alsa.buffer-bytes=1536 alsa.period-bytes=192 alsa.rate={min=48000 max=48000} alsa.format=S32_LE resample.disable=true }"'';
      # env PIPEWIRE_LATENCY="256/48000" OSU_SDL3=0 __GL_THREADED_OPTIMIZATIONS=0 PIPEWIRE_ALSA="{ alsa.buffer-bytes=2048 alsa.period-bytes=256 alsa.rate={min=48000 max=48000} alsa.format=S32_LE resample.disable=true}" ${pkgs.gamemode}/bin/gamemoderun
      # { alsa.buffer-bytes=1024 alsa.period-bytes=64 alsa.rate={min=48000 max=48000} alsa.format=FLOAT_LE alsa.access=RW_INTERLEAVED resample.disable=true node.force-quantum=12 node.latency=12/48000}
      # command_prefix = ''env PIPEWIRE_ALSA="{ alsa.buffer-bytes=1024 alsa.period-bytes=64 }"'';
    })
  ];
}
