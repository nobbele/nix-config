{pkgs, ...}: let
  vpn.host = "remote.liu.se";
  vpn.port = 443;
  vpn.filename = "openforticlient-liu.conf";

  openfortivpn-liu = pkgs.writeShellScriptBin "openfortivpn-liu" ''
    exec ${pkgs.openfortivpn}/bin/openfortivpn \
      -c /etc/${vpn.filename} \
      --cookie-on-stdin \
      --pppd-accept-remote
  '';
  startvpn-liu = pkgs.writeShellScriptBin "startvpn-liu" ''
    ${pkgs.openfortivpn-webview}/bin/openfortivpn-webview "${vpn.host}:${toString vpn.port}" 2>/dev/null \
    | /run/wrappers/bin/sudo /run/current-system/sw/bin/openfortivpn-liu
  '';
in {
  config = {
    environment.systemPackages = with pkgs; [
      openfortivpn
      openfortivpn-webview
      openfortivpn-liu
      startvpn-liu
    ];

    environment.etc."${vpn.filename}" = {
      text = ''
        host=${vpn.host}
        port=${toString vpn.port}
      '';
    };

    security.sudo.extraRules = [
      {
        commands = [
          {
            command = "/run/current-system/sw/bin/openfortivpn-liu";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];

    systemd.user.services.liu-vpn = {
      after = ["network.target"];
      description = "FortiClient VPN for LiU";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${startvpn-liu}/bin/startvpn-liu";
        PassEnvironment = "DISPLAY WAYLAND_DISPLAY XDG_RUNTIME_DIR";
      };
    };
  };
}
