{config, ...}: {
  imports = [./rebuild-scripts.nix];

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.nh = {
    enable = true;
    flake = config.me.flakePath;
  };
}
