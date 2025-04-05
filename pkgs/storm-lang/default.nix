{
  stdenv,
  fetchgit,
  lib,
  pkgs,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "storm-lang";
  version = "0.6.30";

  src = fetchgit {
    url = "git://storm-lang.org/storm.git";
    fetchSubmodules = true;
    tag = "release/${finalAttrs.version}";
    hash = "sha256-1xUXHjUrHDKJPej+rcTOGe7PlSYpsv4oBFjOw1XoGKY=";
  };

  patches = [
    ./no-copy-libs.patch
    # ./shebang-fix.patch
  ];

  nativeBuildInputs = with pkgs; [
    openssl
    libjpeg
    libmysqlclient
    libpng
    openal
    xorg.libX11
    pkg-config
    gtk3
    cairo
  ];

  buildPhase = ''
    export HOME=$PWD
    echo 11 | ${pkgs.mymake}/bin/mm --config
    ${pkgs.mymake}/bin/mm Main release noskia
  '';

  installPhase = ''
    export STORM_PATH=$out/opt/storm
    mkdir -p $STORM_PATH
    mkdir -p $out/bin

    cp -r release/* $STORM_PATH/
    cp -r root/ $STORM_PATH/

    ln -s $out/opt/storm/Storm $out/bin/Storm
  '';

  meta = {
    description = "Mymake is a tool to build C/C++-programs that requires close to no configuration.";
    homepage = "https://github.com/fstromback/mymake";
    license = lib.licenses.mit;
    mainProgram = "mm";
  };
})
