{den, ...}: {
  den.aspects.nobbele = {
    includes = [
      den.provides.primary-user
      (den.provides.user-shell "zsh")
    ];
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        gparted
      ];
    };
    user = {
      extraGroups = [
        "audio"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIeR9KMyT0GybdNVr0lfoZzssQ/imA/St5CQa0B3hBTM realnobbele@gmail.com"
      ];
    };
  };
}
