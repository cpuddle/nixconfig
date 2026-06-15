{ config, lib, pkgs, ... }:
{
    xdg = {
        autostart.enable = true;
        icons.enable = true;
        menus.enable = true;
        sounds.enable = true;
        mime = {
            enable = true;
            defaultApplications = {
                "application/pdf" = "zathura.desktop";
            };
        };
        portal = {
            enable = true;
            xdgOpenUsePortal = true;
            extraPortals = [ 
                pkgs.xdg-desktop-portal-gtk
                pkgs.xdg-desktop-portal-wlr
            ];
            config = {
                common = {
                    default = [ "wlr" "gtk" ];
                };
            };
        };
    };
}

