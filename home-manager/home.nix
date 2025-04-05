{ pkgs, specialArgs, ... }:
let
  inherit (specialArgs) isNixOS;
in
{
  imports = [
    ./modules
    ./options.nix
    ./shared.nix
  ];

  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    kdePackages.polkit-kde-agent-1
  ];

  home.sessionVariables = {

  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "dotnet-runtime-7.0.20"
      "dotnet-sdk-7.0.410"
    ];
  };

  programs.home-manager.enable = true;
  targets.genericLinux.enable = !isNixOS;
  home.username = "nobbele";
  home.homeDirectory = "/home/nobbele";
  home.stateVersion = "24.11";
}
