{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.system}.default
    pkgsi686Linux.gperftools

    mymake
    storm-lang
  ];
}
