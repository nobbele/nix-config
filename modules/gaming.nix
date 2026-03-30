{...}: {
  den.aspects.gaming = {
    homeManager = {
      inputs,
      system,
      pkgs,
      ...
    }: {
      imports = [
        (inputs.nix-gaming.packages.${system}.osu-lazer-bin.override {
          command_prefix = '''';
        })
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
