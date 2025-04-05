{ pkgs, ... }:

{
  imports = [
    ./music-production
  ];

  config = {
    home.glPackages = with pkgs; [
      blender
      gimp
      krita
      libresprite
      kdePackages.kdenlive

      # unstable.famistudio
      # bambootracker
      # furnace
      # reaper
      # yabridge
      # yabridgectl
    ];
  };
}
