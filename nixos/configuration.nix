{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./boot.nix
    ./environment.nix
    ./i18n.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    # inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-7.0.410"
  ];

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

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than +5";
  };

  # TODO move to fonts.nix
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    fira-code
    fira-code-symbols
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.guest.dragAndDrop = true;
  # users.extraGroups.vboxusers.members = ["nobbele"];

  hardware.opentabletdriver.enable = true;
  networking.networkmanager.enable = true;
  security.pam.services.hyprlock = {};
  security.pam.services.sddm.enableKwallet = true;
  # services.printing.enable = true;

  # networking.firewall.allowedTCPPorts = [ 1701 9001 ];

  # security.pam.loginLimits = [
  #   { domain = "@audio"; item = "memlock"; type = "-"   ; value = "unlimited"; }
  #   { domain = "@audio"; item = "rtprio" ; type = "-"   ; value = "99"       ; }
  #   { domain = "@audio"; item = "nofile" ; type = "soft"; value = "99999"    ; }
  #   { domain = "@audio"; item = "nofile" ; type = "hard"; value = "99999"    ; }
  # ];

  # services.udev.extraRules = ''
  #   KERNEL=="rtc0", GROUP="audio"
  #   KERNEL=="hpet", GROUP="audio"
  # '';

  system.stateVersion = "24.05"; # Do not modify!!
}
