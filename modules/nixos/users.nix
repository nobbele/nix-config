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
    ];

    shell = pkgs.zsh;
  };
}