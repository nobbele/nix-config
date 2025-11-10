{lib, ...}: {
  options.custom = {
    flakePath = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = {
    terminal = {
      emulator = "foot";
      prompt = "starship";
    };

    creative = {
      # daw = "lmms";
    };

    defaultApplications = {
      video = "mpv.desktop";
      audio = "mpv.desktop";
      image = "qimgv.desktop";
      archive = "org.kde.ark.desktop";
      browser = "brave-browser.desktop";
      pdf = "brave-browser.desktop";
      file-explorer = "org.kde.dolphin.desktop";
      text = "kate.desktop";
    };
  };
}
