{host, ...}: {
  imports = [
    ./boot.nix
    ./i18n.nix
    ./fonts.nix
    ./tools
    ./hardware
    ./user.nix
    ./audio.nix
    ./desktop.nix
    ./misc.nix
    ./browser.nix
    ./ssh.nix
  ];

  config = {
    networking.hostName = host.hostname;
    networking.networkmanager.enable = true;

    programs.zsh.enable = true;
    services.automatic-timezoned.enable = true;

    nixpkgs.config.allowUnfree = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +3";
    };

    nix.optimise = {
      automatic = true;
      dates = "weekly";
    };

    nix.settings = {
      experimental-features = ["nix-command" "flakes" "pipe-operators"];
      auto-optimise-store = true;

      substituters = [
        "https://nix-gaming.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };
}
