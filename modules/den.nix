{
  inputs,
  lib,
  # den,
  ...
}: {
  imports = [inputs.den.flakeModule];

  den.ctx.user.classes = lib.mkDefault ["homeManager"];
  # den.ctx.user.includes = [den.provides.mutual-provider];
}
