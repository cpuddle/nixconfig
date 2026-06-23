{ config, pkgs, ... }:
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "rmpc_launch" ''
            ${pkgs.foot}/bin/footclient -e rmpc
        '')
    ];
}
