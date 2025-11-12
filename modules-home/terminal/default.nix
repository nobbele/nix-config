{config, ...}: {
  imports = [
    ./shell.nix
    ./fetch.nix
    ./replacements.nix
    ./emulator.nix
    ./prompt.nix
  ];

  home.shellAliases = {
    rbh = "home-manager switch --flake ${config.me.flakePath}#$(whoami)@$(hostname) --impure";
  };
}
