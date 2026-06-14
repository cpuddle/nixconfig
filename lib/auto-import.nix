{ lib, ... }:
let
  inherit (builtins) readDir;
  inherit (lib) hasSuffix;
in
dir:
lib.pipe (readDir dir) [
  (lib.filterAttrs (name: type:
    (type == "directory") ||
    (hasSuffix ".nix" name && name != "default.nix")
  ))
  (lib.mapAttrsToList (name: _: dir + "/${name}"))
]
