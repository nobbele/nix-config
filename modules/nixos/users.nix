{ pkgs, inputs, ... }:

{
  users.users.nobbele = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" ];
    packages = with pkgs; [
      bitwarden-desktop
      discord-canary
      macchina
      google-chrome
      anki-bin
      qemu_full
      webcord
      vesktop
      unstable.qbittorrent
      gimp
      inputs.zen-browser.packages."${system}".specific
      gnome.cheese
      obs-studio
      kdenlive
      unstable.kanata
      inkscape
      libreoffice-qt

      # Dev
      nil
      rustup
      tokei
      eigen
      (unstable.jetbrains.rider.overrideAttrs (attrs: {
        postInstall = (attrs.postInstall or "") + lib.optionalString (stdenv.hostPlatform.isLinux) ''
          (
            cd $out/rider

            for dir in lib/ReSharperHost/linux-*; do
              rm -rf $dir/dotnet
              ln -s ${dotnetCorePackages.sdk_8_0} $dir/dotnet 
            done
          )
        '';
      }))

      # Games
      lutris
      prismlauncher
      winetricks
      corefonts
      wineWowPackages.staging

      # Game Dev
      unstable.godot_4-mono
      unityhub
      blender

      # Music Production
      unstable.famistudio
      bambootracker
      furnace
      reaper
      yabridge
      yabridgectl
    ];

    shell = pkgs.zsh;
  };
}