{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./ghostty.nix
    ./wezterm.nix
    ./kitty.nix
  ];

  options.terminal.emulator = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum [
        "ghostty"
        "wezterm"
        "kitty"
      ]
    );
    default = null;
  };

  config = {
    home.packages = with pkgs; [
      kdePackages.yakuake
      kdePackages.konsole
    ];
  };
}
