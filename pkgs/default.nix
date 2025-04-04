pkgs: 
{
  mymake = pkgs.callPackage ./mymake.nix { };
  storm-lang = pkgs.callPackage ./storm-lang { };
}