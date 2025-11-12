{
  config,
  pkgs,
  lib,
  ...
}: let
  selfCfg = config.me.gaming;
in {
  options.me.gaming = {
    enable = lib.mkEnableOpt;
  };

  config = lib.mkIf selfCfg.enable {
    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    nix-ld.libraries = with pkgs; [
      (runCommand "steamrun-lib" {} "mkdir $out; ln -s ${steam-run.fhsenv}/usr/lib64 $out/lib")
    ];
  };
}
