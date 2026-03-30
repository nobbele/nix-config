{
  config,
  pkgs,
  lib,
  ...
}: let
  selfCfg = config.me.nvidia;

  nvidiaVersionFile =
    pkgs.runCommand "impure-nvidia-version-file" {
      time = builtins.currentTime; # Force impure evaluation.
      preferLocalBuild = true;
      allowSubstitutes = false;
    } ''
      cp /proc/driver/nvidia/version $out 2> /dev/null || touch $out
    '';
  versionMatch = builtins.match ".*Module for x86_64  ([0-9.]+)  .*" (builtins.readFile nvidiaVersionFile);
  nvidiaVersion = builtins.head versionMatch;

  driverUrl = "https://download.nvidia.com/XFree86/Linux-x86_64/${nvidiaVersion}/NVIDIA-Linux-x86_64-${nvidiaVersion}.run";

  nvidiaDriver = builtins.fetchurl {url = driverUrl;};
  nvidiaSha256 = builtins.hashFile "sha256" nvidiaDriver;
in {
  options.me.nvidia = {
    enable = lib.mkEnableOpt;
  };

  config = lib.mkIf selfCfg.enable {
    nixpkgs.config.nvidia.acceptLicense = true;
    targets.genericLinux.gpu.nvidia = {
      enable = true;
      version = nvidiaVersion;
      sha256 = builtins.convertHash {
        hash = nvidiaSha256;
        toHashFormat = "sri";
        hashAlgo = "sha256";
      };
    };
  };
}
