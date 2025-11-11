{...}: let
  flakePath = "/home/nobbele/nix-config";
in {
  nixGL.defaultWrapper = "nvidia";

  custom.flakePath = flakePath;

  # custom.hyprland.enable = true;
  # wayland.windowManager.hyprland.package = null;
  # wayland.windowManager.hyprland.portalPackage = null;

  # custom.helix.enable = true;
  # custom.emacs.enable = true;

  terminal.shell.alises = {
    rbh = "home-manager switch --flake ${flakePath}#$(whoami)@$(hostname) --impure";
  };

  programs.hyfetch.settings.distro = "unicodearch";

  home.sessionPath = [
    "/opt/outfox/"
  ];
}
