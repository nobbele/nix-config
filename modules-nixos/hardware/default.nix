{...}: {
  imports = [
    ./laptop.nix
    ./yubikey.nix
  ];

  hardware.opentabletdriver.enable = true;
}
