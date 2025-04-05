{ pkgs, ... }:

{
  imports = [
    ./vscode.nix
  ];

  config = {
    home.packages = with pkgs; [
      tokei
    ];
  };
}
