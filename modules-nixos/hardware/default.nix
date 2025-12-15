{...}: {
  imports = [
    ./yubikey.nix
  ];

  hardware.opentabletdriver.enable = true;
}
