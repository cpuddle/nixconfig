{ inputs, lib, ... }:
let
  overlays = {
    additions =
      final: prev:
      (
        prev.lib.packagesFromDirectoryRecursive {
          callPackage = prev.lib.callPackageWith final;
          directory = ../pkgs;
        }
        // { }
      )
      // { };
  };
in
{
    default =
        final: prev:
        lib.mergeAttrsList (map (name: overlays.${name} final prev) (lib.attrNames overlays));
}
