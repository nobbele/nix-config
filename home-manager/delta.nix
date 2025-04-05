{ ... }:

let
  flakePath = "/home/nobbele/.nixos";
in
{
  # nixGL.defaultWrapper = "nvidia";
  nixGL.defaultWrapper = "mesa";

  terminal.shell.alises = {
    rebuild = "sudo nixos-rebuild switch --flake ${flakePath} -I ${flakePath}/nixos/configuration.nix --impure";
    rebuildhome = "home-manager switch --flake ${flakePath}#$(whoami)@$(hostname) --impure";
    # hm = "home-manager";
    # hms = "home-manager switch";
  };

  development.vscode.enabled = true;
}
