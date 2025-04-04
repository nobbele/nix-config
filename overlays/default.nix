{inputs, ...}: {
  local-packages = final: _prev: import ../pkgs final.pkgs;

  unstable-packages = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
      config.permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
      ];
    };
  };
}