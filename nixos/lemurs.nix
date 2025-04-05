{
  pkgs,
  inputs,
  config,
  ...
}: {
  security.pam.services.lemurs = {
    allowNullPassword = true;
    startSession = true;
    setLoginUid = false;
  };

  systemd.services."autovt@tty2".enable = false;
  systemd.defaultUnit = "graphical.target";

  systemd.services.lemurs = {
    aliases = ["display-manager.service"];

    unitConfig = {
      Wants = [
        "systemd-user-sessions.service"
      ];

      After = [
        "systemd-user-sessions.service"
        "getty@$tty2.service"
      ];

      Conflicts = [
        "getty@tty2.service"
      ];
    };

    serviceConfig = {
      ExecStart = let
        sessionData = config.services.displayManager.sessionData;
      in ''
        ${inputs.lemurs.packages."${pkgs.system}".default}/bin/lemurs \
          --xsessions ${sessionData.desktops.outPath}/share/xsessions \
         --wlsessions ${sessionData.desktops.outPath}/share/wayland-sessions \
      '';

      StandardInput = "tty";
      TTYPath = "/dev/tty2";
      TTYReset = "yes";
      TTYVHangup = "yes";

      Type = "idle";
    };

    restartIfChanged = false;

    wantedBy = ["graphical.target"];
  };
}
