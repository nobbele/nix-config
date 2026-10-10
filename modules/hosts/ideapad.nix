{ ... }:
{
  den.hosts.x86_64-linux.ideapad.users.alice = {};
  
  den.aspects.ideapad = {
    nixos = { ... }: {
        imports = [
            ./ideapad/_hardware.nix
        ];

        boot.initrd.luks.devices."luks-5897571a-9703-45bf-af3b-df322f20ed15".device = "/dev/disk/by-uuid/5897571a-9703-45bf-af3b-df322f20ed15";

        services.printing.enable = true;
    };
  };
}
