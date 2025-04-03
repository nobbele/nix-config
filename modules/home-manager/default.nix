{ pkgs, inputs, config, ... }:

{
  imports = [
    ./zsh.nix
    ./vscode.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "nobbele";
    homeDirectory = "/home/nobbele";
    packages = with pkgs; [
      bat
      ripgrep
      lsd
      (inputs.nix-gaming.packages."${system}".osu-lazer-bin.override {
        pipewire_latency = "256/48000";
      })
      csharpier
      pdfpc
    ];

    file."${config.xdg.configHome}/${{
      "vscode" = "Code";
      "vscode-insiders" = "Code - Insiders";
      "vscodium" = "VSCodium";
    }.${config.programs.vscode.package.pname}}/User/settings.json".force = true;
  };

  programs = {
    zoxide.enable = true;
    bat.enable = true;
    ripgrep.enable = true;
    lsd.enable = true;
  };

  home.stateVersion = "24.05"; # Do not modify!!
}