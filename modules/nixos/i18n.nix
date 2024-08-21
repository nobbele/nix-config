{ ... }:

{
  services.xserver.xkb = { layout = "se"; variant = "nodeadkeys"; };
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;
}