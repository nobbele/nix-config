{ inputs, ... }:
let
  overlay = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (prev.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  };
in
{
  den.default.nixos.nixpkgs.overlays = [ overlay ];
  den.default.homeManager.nixpkgs.overlays = [ overlay ];
}
