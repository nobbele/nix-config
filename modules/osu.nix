{
  den.aspects.osu = {
    nixos = { pkgs, ... }: {
      hardware.uinput.enable = true;
      hardware.opentabletdriver = {
        enable = true;
        package = pkgs.opentabletdriver;
      };
    };
  };
}