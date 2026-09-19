{ ... }:
{
  den.aspects.motd = {
    homeManager = {
      programs.macchina = {
        enable = true;

        settings = {
          long_uptime = true;
          disk_space_percentage = true;
          memory_percentage = true;
          disks = ["/" "/home"];
        };
      };

      programs.hyfetch = {
        enable = true;
        settings = {
          preset = "demigirl";
          mode = "rgb";
          color_align = {
            mode = "horizontal";
          };
          backend = "macchina";
          pride_month_disable = false;
        };
      };

      programs.zsh.initContent = "hyfetch";
    };
  };
}