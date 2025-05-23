{...}: let
  flakePath = "/home/nobbele/nix-config";
in {
  nixGL.defaultWrapper = "nvidia";

  custom.flakePath = flakePath;

  # custom.hyprland.enable = true;
  # wayland.windowManager.hyprland.package = null;
  # wayland.windowManager.hyprland.portalPackage = null;

  # custom.helix.enable = true;
  custom.emacs.enable = true;

  # programs.hyfetch.settings.distro = "arch_small";

  terminal.shell.alises = {
    rbh = "home-manager switch --flake ${flakePath}#$(whoami)@$(hostname) --impure";
  };

  home.sessionPath = [
    "/opt/outfox/"
  ];
}
