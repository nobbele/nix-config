{ inputs, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./environment.nix
    ./i18n.nix
    ./networking.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    # ./lemurs.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;

    substituters = [
      "https://nix-gaming.cachix.org"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than +5";
  };

  # TODO move to fonts.nix
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.draganddrop = true;
  users.extraGroups.vboxusers.members = [ "nobbele" ];

  system.copySystemConfiguration = true;
  system.stateVersion = "24.05"; # Do not modify!!
}
