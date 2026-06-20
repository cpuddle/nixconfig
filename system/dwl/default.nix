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
        direnv
    ];

    environment = {
        localBinInPath = true;
        sessionVariables = {
            PATH = [ "/usr/local/bin" ];
        };
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };
    
    programs = {
        dwl = {
            enable = true;
            package = pkgs.dwl.overrideAttrs (old : {
                src = builtins.path {
                    path = ./src;
                    name = "dwl-source";
                };
                version = "0.8-custom";
            });
        };
        xwayland = {
            enable = true;
        };
        nm-applet = {
            enable = true;
        };
    };
}
