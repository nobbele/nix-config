{ pkgs, ... }:

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
      winetricks
      corefonts
      gnome.cheese
      prismlauncher
      unityhub
      eigen
    ];

    shell = pkgs.zsh;
  };
}