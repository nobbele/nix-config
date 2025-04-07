{
  lib,
  pkgs,
  ...
}: let
  options = [
    {
      title = "Lock";
      cmd = "hyprlock";
    }
    {
      title = "Log out";
      cmd = "hyprctl dispatch exit";
    }
    {
      title = "Suspend";
      cmd = "systemctl suspend";
    }
    {
      title = "Shutdown";
      cmd = "systemctl poweroff";
    }
    {
      title = "Reboot";
      cmd = "systemctl reboot";
    }
  ];
  optionsText = lib.strings.concatImapStringsSep "\n" (pos: option: "${builtins.toString pos} - ${option.title}") options;
  fuzzelCommand = ''${pkgs.fuzzel}/bin/fuzzel --dmenu -l ${builtins.toString (builtins.length options)} -p "Power Menu: "'';
in
  pkgs.writeShellScript "powermenu" ''
    #!/usr/bin/env bash

    SELECTION="$(printf "${optionsText}" | ${fuzzelCommand})"

    case $SELECTION in
      ${lib.strings.concatMapStrings ({
      title,
      cmd,
    }: ''*"${title}") ${cmd};;'')
    options}
    esac
  ''
