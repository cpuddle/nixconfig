{ lib, ... }@args:
{
  imports = (import ../lib/auto-import.nix args) ./.;
}
