{pkgs, ...}: {
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    # LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  };
}
