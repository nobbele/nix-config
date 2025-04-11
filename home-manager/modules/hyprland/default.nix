{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.lib) nixGL;
  cfgHyprland = config.custom.hyprland;

  terminalBinary = "${pkgs.foot}/bin/foot";
  appLauncherBinary = "${pkgs.fuzzel}/bin/fuzzel";

in {
  options.custom.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };

  imports = [
    ./hyprlock
  ];

  config = lib.mkIf cfgHyprland.enable {
    home.packages = with pkgs; [
      hyprpolkitagent
    ];

    services.mako = {
      enable = true;
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = "${./wallpaper.png}";
        wallpaper = ", ${./wallpaper.png}";
      };
    };

    /*
    exec-once = kwalletd5&
    exec-once = /usr/lib/pam_kwallet_init
    */

    # programs.waybar = {
    #   enable = true;
    #   settings.mainBar = import ./waybar/settings.nix {inherit pkgs lib;};
    #   style = import ./waybar/style.nix {};
    # };

    programs.eww = {
      enable = true;
      configDir = ../../dotfiles/eww;
    };

    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = terminalBinary;
          layer = "overlay";
        };
        colors.background = "ffffffff";
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      # package = nixGL.wrap pkgs.hyprland;
      # portalPackage = nixGL.wrap pkgs.xdg-desktop-portal-hyprland;

      settings = let
        startupScript = pkgs.pkgs.writeShellScript "start" ''
          systemctl --user start hyprpolkitagent
          eww daemon
          eww open bar-main
          hyprpaper &
        '';
      in {
        exec-once = "${startupScript}";

        general = {
          "col.active_border" = "rgb(FDB7EA)";
          border_size = 2;
          gaps_out = "10,10,10,10";
        };

        input = {
          kb_layout = "se";
          kb_variant = "nodeadkeys";
        };

        cursor.no_hardware_cursors = 1;

        "$mod" = "SUPER";
        bind =
          [
            "$mod, Q, killactive,"
            "$mod, F, fullscreen,"
            "$mod, L, exec, ${pkgs.hyprlock}/bin/hyprlock"
            # ", Print, exec, grimblast copy area"

            # "$mod, F, exec, firefox"
            "$mod, R, exec, ${appLauncherBinary}"
            "$mod, T, exec, ${terminalBinary}"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (
                i: let
                  ws = i + 1;
                in [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9)
          );
      };
    };
  };
}
