{pkgs, ...}: {
  imports = [
    ./vscode.nix
    ./helix.nix
    # ./emacs.nix
  ];

  config = {
    home.packages = with pkgs; [
      tokei
      xmake
    ];
  };
}
