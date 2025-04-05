{
  stdenv,
  fetchgit,
  lib,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "mymake";
  version = "2.3.6";

  src = fetchgit {
    url = "https://github.com/fstromback/mymake";
    tag = "v${finalAttrs.version}";
    hash = "sha256-UQjvxdOvD9O6TrzBFJwh3CistDGZM9HZbcwVPx1n4+A=";
  };

  buildPhase = ''
    ./compile.sh mm
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp mm $out/bin
  '';

  meta = {
    description = "Mymake is a tool to build C/C++-programs that requires close to no configuration.";
    homepage = "https://github.com/fstromback/mymake";
    license = lib.licenses.mit;
    mainProgram = "mm";
  };
})
