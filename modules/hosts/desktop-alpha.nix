{ ... }:
{
  den.hosts.x86_64-linux.desktop-alpha.users.alice = {};
  
  den.aspects.desktop-alpha = {
    nixos = {
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
    };
  };
}
