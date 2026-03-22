{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./games.nix
    ./emacs.nix
    ./vscode.nix
    ./creative.nix
    ./browser.nix
  ];

  config = {
    home.packages = with pkgs; [
      qimgv
      qbittorrent
      bitwarden-desktop
      protonmail-desktop
    ];

    # TODO include brave, ark, kate and dolphin here..

    programs.mpv = {
      package = config.lib.nixGL.wrap pkgs.mpv;
      enable = true;
    };

    me.defaultApplications = {
      video = "mpv.desktop";
      audio = "mpv.desktop";
      image = "qimgv.desktop";
      archive = "org.kde.ark.desktop";
      browser = "floorp.desktop";
      pdf = "floorp.desktop";
      file-explorer = "org.kde.dolphin.desktop";
      text = "kate.desktop";
    };

    programs.obs-studio = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.obs-studio;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
      ];
    };
  };
}
