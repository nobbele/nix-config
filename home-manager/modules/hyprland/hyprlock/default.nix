{
  lib,
  config,
  ...
}: let
  cfgHyprland = config.custom.hyprland;
in {
  config = lib.mkIf cfgHyprland.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 5;
          hide_cursor = true;
        };

        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "500, 100";
            position = "0, -350";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
            shadow_passes = 2;
          }
        ];

        image = [
          {
            monitor = "";
            path = "${./image.png}";
            size = 800;
            rounding = 0;
            border_color = "rgba(0, 0, 0, 0)";

            position = "0, 200";
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          {
            monitor = "";
            text = "Please enter your password, $USER";
            color = "rgba(200, 200, 200, 1.0)";
            font_size = 25;

            position = "0, 700";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
