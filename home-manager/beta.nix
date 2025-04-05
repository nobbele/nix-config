{ ... }:

let
  flakePath = "/home/nobbele/nix-config";
in
{
  nixGL.defaultWrapper = "nvidia";

  terminal.shell.alises = {
    rebuildhome = "home-manager switch --flake ${flakePath}#$(whoami)@$(hostname) --impure";
  };
}
