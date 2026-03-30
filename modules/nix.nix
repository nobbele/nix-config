{inputs, ...}: {
  den.default = {
    nixos = {
      nixpkgs.config.allowUnfree = true;
      nix = {
        registry.nixpkgs.flake = inputs.nixpkgs;
        optimise.automatic = false;
        gc.automatic = true;

        settings = {
          experimental-features = ["nix-command" "flakes" "pipe-operators"];
          auto-optimise-store = true;

          substituters = [
            "https://aseipp-nix-cache.global.ssl.fastly.net"
            "https://cache.nixos.org/"
            "https://nix-gaming.cachix.org"
            "https://nix-community.cachix.org"
            "https://devenv.cachix.org"
          ];
          trusted-public-keys = [
            "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          ];
        };
      };
    };
  };
}
