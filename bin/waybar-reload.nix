{ config, pkgs, ... }:
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "waybar_reload" ''
            pkill -x waybar || true
            sleep .5
            ${pkgs.waybar}/bin/waybar &
            disown
        '')
    ];
}
