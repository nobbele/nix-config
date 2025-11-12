{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkOptionalModule config "me.apps.creative" {
  home.glPackages = with pkgs; [
    blender
    gimp
    krita
    libresprite
    kdePackages.kdenlive
  ];
}
