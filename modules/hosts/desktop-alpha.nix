{ den, inputs, ... }:
{
  den.hosts.x86_64-linux.desktop-alpha.users.alice = {};
  
  den.aspects.desktop-alpha = {
    nixos = { pkgs, ... }: {
      imports = [
        ./desktop-alpha/_hardware.nix
      ];

      fileSystems = {
        "/".options = [ "compress=zstd" ];
        "/home".options = [ "compress=zstd" ];
        "/nix".options = [ "compress=zstd" "noatime" ];
      };

      services.btrfs.autoScrub = {
        enable = true;
        interval = "monthly";
        fileSystems = [ "/" ];
      };

      services.xserver.videoDrivers = ["nvidia"];
      hardware.nvidia.modesetting.enable = true;
      hardware.nvidia.open = true;

      services.udev.packages = with pkgs; [ openocd ];
      
      users.groups.plugdev = {};
      users.users."alice".extraGroups = ["plugdev"];
    };

    provides.alice = {
      includes = [ den.aspects.osu ];

      homeManager = { pkgs, ... }: {
        home.packages = with pkgs; [
          faugus-launcher
          (inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin.override {
            pipewire_latency = "128/44100";
          })

          gimp
          libresprite
          godot

          rustup
          gcc
          probe-rs-tools
        ];
      };
    };
  };
}
