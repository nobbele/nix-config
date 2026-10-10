{
  den.aspects.cleanup = {
    nixos = {
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
    };

    homeManager = { pkgs, config, ... }: {
      systemd.user.services.downloads-cleanup = {
        Unit.Description = "Clean up old downloads";

        Service = {
          Type = "oneshot";
          ExecStart = let 
            find = "${pkgs.findutils}/bin/find";
            downloads = "${config.home.homeDirectory}/Downloads";
          in [
            "${find} ${downloads} -type f -atime +14 -delete"
            "${find} ${downloads} -depth -type d -empty -delete"
          ];
        };
      };

      systemd.user.timers.downloads-cleanup = {
        Unit.Description = "Daily downloads cleanup";

        Timer = {
          OnCalendar = "daily";
          Persistent = true;
        };

        Install.WantedBy = [ "timers.target" ];
      };
    };
  };
}