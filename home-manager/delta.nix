{ ... }:

let
  flakePath = "/home/nobbele/.nixos";
in
{
  nixGL.defaultWrapper = "mesa";

  terminal.shell.alises = {
    rb = "sudo nixos-rebuild switch --flake ${flakePath} -I ${flakePath}/nixos/configuration.nix --impure";
    rbh = "home-manager switch --flake ${flakePath}#$(whoami)@$(hostname) --impure";
  };

  development.vscode.enabled = true;
}
