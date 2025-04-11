{
  lib,
  pkgs,
  ...
}: {
  height = 35;
  spacing = 4;
  # reload_style_on_change = true;
  modules-left = [
    "custom/logo"
    "clock"
    "hyprland/workspaces"
  ];
  modules-center = [
    "hyprland/window"
  ];
  modules-right = [
    "battery"
  ];
  "custom/logo" = {
    format = " ";
    tooltip = false;
    on-click = import ./powermenu.nix {inherit pkgs lib;};
  };
  clock = {
    # format = "{:%I:%M:%S %p}";
    format = "{:%H:%M}";
    interval = 1;

    locale = "en_GB.UTF-8";
    tooltip-format = "<tt><small>{calendar}</small></tt>";
    calendar = {
      weeks-pos = "right";
      format = {
        today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        weekdays = "<span color='#ffcc66'><b>{}</b></span>";
        days = "<span color='#ecc6d9'><b>{}</b></span>";
        weeks = "<span color='#99ffdd'><b>W{}</b></span>";
        months = "<span color='#ffead3'><b>{}</b></span>";
      };
    };
  };
  "hyprland/workspaces" = {
    format = "<sub>{icon}</sub>\n{windows}";
    window-rewrite-default = "";
    window-rewrite = {
      # "title<.*youtube.*>" = "";
      "class<firefox>" = "";
      # "class<firefox> title<.*github.*>" = "";
      "foot" = "";
      "code" = "󰨞";
    };
    # "on-scroll-up" = "hyprctl dispatch workspace e+1";
    # "on-scroll-down" = "hyprctl dispatch workspace e-1";
  };
  "hyprland/window" = {
    "format" = "( {class} )";
    icon = true;
  };
  "battery" = {
    "interval" = 1;
    "states" = {
      "good" = 95;
      "warning" = 30;
      "critical" = 20;
    };
    "format" = "{capacity}% <span font='16px'>{icon}</span>";
    "format-charging" = "{capacity}% <span font='16px'>{icon}</span>";
    # "format-full" = "{capacity}% {icon}";
    "format-plugged" = "{capacity}% 󰠠";
    # "format-alt" = "{time} {icon}";
    "format-icons" = [
      "󰪞"
      "󰪟"
      "󰪠"
      "󰪡"
      "󰪢"
      "󰪣"
      "󰪤"
      "󰪥"
    ];
  };
}
