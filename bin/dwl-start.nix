{ pkgs, ... }:
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "dwl-init" ''
            ${pkgs.swaybg}/bin/swaybg -i $HOME/nixconfig/assets/wallpapers/outer-wilds-4k.png -m fill -o DP-1 &
        '')
        (pkgs.writeShellScriptBin "dwl-start" ''
            exec ${pkgs.dwl}/bin/dwl -s dwl-init
        '')
    ];
}
