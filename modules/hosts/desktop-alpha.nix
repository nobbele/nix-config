{ ... }:
{
  den.hosts.x86_64-linux.desktop-alpha.users.alice = {};
  
  den.aspects.desktop-alpha = {
    nixos = {
        imports = [
            ./desktop-alpha/_hardware.nix
        ];

        services.xserver.videoDrivers = ["nvidia"];
        hardware.nvidia.modesetting.enable = true;
        hardware.nvidia.open = true;
    };
  };
}
