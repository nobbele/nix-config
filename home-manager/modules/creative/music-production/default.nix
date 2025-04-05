{ lib, ... }:

{
  imports = [
    ./lmms.nix
  ];

  options.creative = {
    daw = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "lmms"
        ]
      );
      default = null;
    };
  };
}
