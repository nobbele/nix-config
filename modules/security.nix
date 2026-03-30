{...}: {
  den.default.nixos = {
    security.sudo.extraConfig = ''
      Defaults:picloud secure_path="/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:/home/nobbele/.nix-profile/bin"
    '';
  };
}
