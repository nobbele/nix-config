{pkgs, ...}: {
  services.xserver.xkb = {
    layout = "se";
    variant = "nodeadkeys";
  };
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "sv_SE.UTF-8/UTF-8"
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    # waylandFrontend = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      kdePackages.fcitx5-chinese-addons
      kdePackages.fcitx5-qt
      fcitx5-table-extra

      rime-data
      fcitx5-rime
    ];
  };
}
