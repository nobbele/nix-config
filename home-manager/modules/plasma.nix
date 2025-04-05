{ config, ... }:

{
  config = {
    home.file = {
      "${config.home.homeDirectory}/.config/plasma-workspace/env/path.sh" = {
        text = ''
          export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
          export XDG_DATA_DIRS=$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS
          export XDG_DATA_DIRS=/var/lib/flatpak/exports/share:$XDG_DATA_DIRS
        '';
      };
    };
  };
}
