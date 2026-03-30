{lib}: {
  mkOpt = type: default:
    lib.mkOption {inherit type default;};

  mkOpt' = type: lib.mkOption {inherit type;};

  mkEnableOpt = lib.mkOpt lib.types.bool false;

  mkOptionalModule = config: path: module: let
    keys = lib.splitString "." path;
  in {
    options = lib.setAttrByPath keys {enable = lib.mkEnableOpt;};
    config = lib.mkIf (lib.getAttrFromPath keys config).enable module;
  };
}
