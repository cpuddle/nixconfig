{ config, pkgs, ... }:
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "ncmpcpp_launch" ''
            ${pkgs.foot}/bin/footclient -e ncmpcpp
        '')
    ];
}
