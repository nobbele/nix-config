{
  pkgs,
  specialArgs,
  inputs,
  ...
}: let
  inherit (specialArgs) isNixOS;
in {
  imports = [
    ./modules
    ./options.nix
    ./shared.nix
  ];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nixd
    alejandra
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  home.shellAliases = {
    cd = "z";
    ls = "eza";
    cat = "bat";
    grep = "rg --color=auto";
  }
  ;

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
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
