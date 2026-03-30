{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkOptionalModule config "me.dev.storm" {
  home.packages = with pkgs; [
    # storm-lang
    mymake
  ];
}
