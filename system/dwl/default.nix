{ config, lib, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        wl-clipboard
        wlr-randr
        jq
        grim
        slurp
        waybar
        mako
        rofi
        swaybg
        thunar
        gparted
        kdePackages.dolphin
        kdePackages.ark
        kdePackages.gwenview
    ];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    systemd.user.services.polkit-gnome-agent = {
        description = "Polkit GNOME Authentication Agent";
        unitConfig = {
            StartLimitBurst = 3;
            StartLimitIntervalSec = "30s";
        };
        wantedBy = [ "graphical-session.target" ];
        after = [ "graphical-session.target" "dbus.service" ];
        wants = [ "dbus.service" ];
        serviceConfig = {
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = "3s";
        };
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
