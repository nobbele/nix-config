{pkgs, ...}: {
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-7.0.410"
  ];

  home.packages = with pkgs; [
    (
      with dotnetCorePackages;
        combinePackages [
          sdk_7_0
          sdk_8_0
        ]
    )
  ];
}
