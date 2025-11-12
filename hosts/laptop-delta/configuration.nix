{
  pkgs,
  inputs,
  ...
}: {
  # me.tools.container.enable = true;

  me.hardware.laptop.enable = true;
  me.browser.enable = true;
  me.audio.lowLatency = true;
  me.ssh.server.enable = false;

  security.pam.services.sddm.enableKwallet = true;

  # TODO Make this prettier..
  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
    killall
    (inputs.nix-gaming.packages."${pkgs.stdenv.hostPlatform.system}".osu-lazer-bin.override {
      command_prefix = '''';
    })
  ];

  hardware.bluetooth.enable = true;

  system.stateVersion = "24.05"; # Do not modify!!
}
