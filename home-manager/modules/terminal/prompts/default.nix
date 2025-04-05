{ lib, ... }:

{
  imports = [ ./starship.nix ];

  options.terminal.prompt = lib.mkOption {
    type = lib.types.nullOr (lib.types.enum [ "starship" ]);
    default = null;
  };
}
