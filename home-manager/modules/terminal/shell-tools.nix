{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      eza
      ripgrep
    ];

    programs.bat.enable = true;
    programs.ripgrep.enable = true;
    programs.eza = {
      enable = true;
      colors = "auto";
    };
    programs.zoxide = {
      enable = true;
    };
  };
}
