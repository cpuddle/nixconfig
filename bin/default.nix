{ pkgs, ... }:
{
    imports = [
        ./dwl-start.nix
        ./volume.nix
        ./rmpc-launch.nix
        ./powermenu.nix
        ./waybar-reload.nix
        ./music-restart.nix
        ./screenshot.nix
    ];
}
