{ config, pkgs, ... }:
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "email" ''
            ${pkgs.foot}/bin/footclient -e aerc
        '')
    ];
}
