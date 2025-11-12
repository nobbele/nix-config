{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "rbh";
      runtimeInputs = with pkgs; [nix-output-monitor];
      text = ''
        home-manager switch --flake ${config.me.flakePath}#"$(whoami)@$(hostname)" --impure "$@" |& nom
      '';
    })
  ];
}
