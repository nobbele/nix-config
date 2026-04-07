{...}: {
  den.aspects.gaming = {
    homeManager = {
      inputs,
      pkgs,
      ...
    }: {
      home.packages = [
        inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
      ];
    };

    nixos = {
      programs.gamemode.enable = true;
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
    };
  };
}
