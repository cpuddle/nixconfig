{ config, pkgs, ... }:
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "waybar_reload" ''
            ${pkgs.killall}/bin/killall -w waybar .waybar-wrapped 2>/dev/null || true
            ${pkgs.waybar}/bin/waybar &
            disown
        '')
    ];
}
