{pkgs, ...}: {
  users.users.nobbele = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
    ];

    shell = pkgs.zsh;
  };
}
