{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./ghostty.nix
    ./wezterm.nix
    ./kitty.nix
    ./foot.nix
  ];

  options.terminal.emulator = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum [
        "ghostty"
        "wezterm"
        "kitty"
        "foot"
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
