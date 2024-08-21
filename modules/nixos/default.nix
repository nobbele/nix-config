{ ... }:

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
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };
  
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than +5";
  };

  system.copySystemConfiguration = true;
  system.stateVersion = "24.05"; # Do not modify!!
}