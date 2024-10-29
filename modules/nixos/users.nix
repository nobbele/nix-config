{ pkgs, inputs, ... }:

{
  users.users.nobbele = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      nil
      bitwarden-desktop
      discord-canary
      vscode.fhs
      rustup
      macchina
      google-chrome
      anki-bin
      qemu_full
      unstable.famistudio
      webcord
      lutris
      qbittorrent
      gimp
      wineWowPackages.staging
      inputs.zen-browser.packages."${system}".specific
      winetricks
      corefonts
      gnome.cheese
      prismlauncher
      unityhub
      eigen
      bambootracker
      furnace
      obs-studio
    ];

    shell = pkgs.zsh;
  };
}