{ config, lib, pkgs, ... }:
{
    security.polkit = {
        enable = true;
        extraConfig = ''
            polkit.addRule(function(action, subject) {
                if (action.id === "org.freedesktop.login1.suspend" &&
                    subject.isInGroup("wheel")) {
                    return polkit.Result.YES;
                }
            });            
        '';
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

}

