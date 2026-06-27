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
        gnupg
        pinentry-curses
        btop
        foliate
        onlyoffice-desktopeditors
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

    services.udisks2.enable = true;
    
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
        
        gnupg = {
            agent = {
                enable = true;
                pinentryPackage = pkgs.pinentry-curses;
                settings = {
                    default-cache-ttl = 86400;
                    max-cache-ttl = 604800;
                };
            };
        };
    };
}
