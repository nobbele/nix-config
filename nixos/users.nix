{pkgs, ...}: {
  users.users.nobbele = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIeR9KMyT0GybdNVr0lfoZzssQ/imA/St5CQa0B3hBTM realnobbele@gmail.com"
    ];

    shell = pkgs.zsh;
  };
}
