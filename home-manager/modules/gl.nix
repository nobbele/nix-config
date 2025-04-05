{
  lib,
  pkgs,
  config,
  ...
}: {
  options.home.glPackages = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [];
    description = "The set of packages to appear in the user environment with nixGL wrapper.";
  };

  config = {
    home.packages = map config.lib.nixGL.wrap config.home.glPackages;

    nixGL.packages = import <nixgl> {inherit pkgs;};
  };
}
