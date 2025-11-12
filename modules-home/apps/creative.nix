{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkOptionalModule config "me.apps.creative" {
  home.packages = with pkgs; [
    blender
    gimp
    krita
    libresprite
    kdePackages.kdenlive
  ];
}
