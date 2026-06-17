{ config, pkgs, ... }:
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "power_menu" ''
            chosen=$(printf "Shutdown\nReboot\nSuspend" | rofi -dmenu -i \
                -theme-str 'window {width: 100px;}' \
                -theme-str 'listview {lines: 3;} prompt {enabled: false;} entry {enabled: false;}')
            case "$chosen" in
                "Shutdown") systemctl poweroff ;;
                "Reboot")   systemctl reboot ;;
                "Suspend")  systemctl suspend ;;
            esac
        '')
    ];
}
