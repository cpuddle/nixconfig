{ config, pkgs, ... }:
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "volume_up" ''
            wpctl set-volume @DEFAULT_SINK@ 1%+
        '')
        (pkgs.writeShellScriptBin "volume_down" ''
            wpctl set-volume @DEFAULT_SINK@ 1%-
        '')
    ];
}
