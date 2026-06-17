{ config, pkgs, ... }:
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "music_restart" ''
            systemctl --user restart mpv-stream
        '')
    ];
}
