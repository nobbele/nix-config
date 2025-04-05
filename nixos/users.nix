{pkgs, ...}: {
  users.users.nobbele = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
    ];
    # packages = with pkgs; [ ];

    shell = pkgs.zsh;
  };
}
