{...}: let
  flakePath = "/home/nobbele/nix-config";
in {
  nixGL.defaultWrapper = "nvidia";

  custom.hyprland.enable = true;
  wayland.windowManager.hyprland.package = null;
  wayland.windowManager.hyprland.portalPackage = null;

  terminal.shell.alises = {
    rbh = "home-manager switch --flake ${flakePath}#$(whoami)@$(hostname) --impure";
  };

  home.sessionPath = [
    "/opt/outfox/"
  ];
}
