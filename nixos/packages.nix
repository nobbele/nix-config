{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.system}.default
    killall
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
  ];
}
