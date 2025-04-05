{pkgs, ...}: {
  imports = [
  ];

  config = {
    home.glPackages = with pkgs; [
      vintagestory
      lutris
      # prismlauncher
    ];
  };
}
