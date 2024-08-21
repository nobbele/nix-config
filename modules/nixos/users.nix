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
    ];

    shell = pkgs.zsh;
  };
}