{ config, lib, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        wl-clipboard
        wlr-randr
        jq
        grim
        slurp
        waybar
        mpv
        imv
        mako
        rofi
        swaybg
        thunar
        nemo-fileroller
        gparted
    ];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };
    
    programs = {
        dwl = {
            enable = true;
            package = pkgs.dwl.overrideAttrs {
                src = ./src;
            };
        };
        xwayland = {
            enable = true;
        };
        nm-applet = {
            enable = true;
        };
    };
}
