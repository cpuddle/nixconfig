{ config, lib, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        wl-clipboard
        grim
        slurp
        waybar
        mako
        rofi
        swaybg
        kdePackages = {
            dolphin
            ark
            gwenview
        };
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
